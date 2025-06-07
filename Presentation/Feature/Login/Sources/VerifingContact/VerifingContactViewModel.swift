//
//  VerifingContactViewModel.swift
//  Login
//
//  Created by eunseou on 1/11/25.
//

import SwiftUI
import Observation
import DesignSystem
import PCFoundationExtension
import UseCases
import LocalStorage

@Observable
final class VerifingContactViewModel {
  private enum Constants {
    static let initialTime: Int = 300
    static let buttonDefaultWidth: CGFloat = 111
    static let buttonExpandedWidth: CGFloat = 125
  }
  
  enum Action {
    case updateScenePhase(ScenePhase)
    case reciveCertificationNumber
    case checkCertificationNumber
    case tapNextButton
  }
  
  private let sendSMSCodeUseCase: SendSMSCodeUseCase
  private let verifySMSCodeUseCase: VerifySMSCodeUseCase
  
  var showDuplicatePhoneNumberAlert: Bool = false
  private(set) var showVerificationField: Bool = false
  private(set) var isPhoneVerificationCompleted: Bool = false
  private(set) var tapNextButtonFlag: Bool = false
  private(set) var recivedCertificationNumberButtonText: String = "인증번호 받기"
  private(set) var recivedCertificationNumberButtonWidth = Constants.buttonDefaultWidth
  private(set) var oauthProviderName: String = ""
  var verificationFieldInfoText: String = "어떤 경우에도 타인에게 공유하지 마세요"
  var verrificationFieldInfoTextColor: Color = DesignSystemAsset.Colors.grayscaleDark3.swiftUIColor
  private var timer: Timer?
  private var timeRemaining = Constants.initialTime
  var phoneNumber: String = ""
  var verificationCode: String = ""
  var isVerificationCodeValid: Bool {
    !verificationCode.isEmpty
    && verificationCode.count >= 4
    && !isPhoneVerificationCompleted
  }
  var isPhoneNumberValid: Bool {
    !phoneNumber.isEmpty
    && (phoneNumber.count == 11 || phoneNumber.count == 10)
    && !isPhoneVerificationCompleted
  }
  var phoneNumberTextfieldButtonType: RoundedButton.ButtonType {
    buttonType(for: isPhoneNumberValid)
  }
  var verificationCodeTextfieldButtonType: RoundedButton.ButtonType {
    buttonType(for: isVerificationCodeValid)
  }
  var nextButtonType: RoundedButton.ButtonType {
    buttonType(for: isPhoneVerificationCompleted)
  }
  var timerText: String {
    isPhoneVerificationCompleted
    ? ""
    : timeRemaining.formattedTime
  }
  
  init(
    sendSMSCodeUseCase: SendSMSCodeUseCase,
    verifySMSCodeUseCase: VerifySMSCodeUseCase
  ) {
    self.sendSMSCodeUseCase = sendSMSCodeUseCase
    self.verifySMSCodeUseCase = verifySMSCodeUseCase
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .updateScenePhase(let scenePhase):
      handleScenePhase(for: scenePhase)
    case .reciveCertificationNumber:
      Task { await handleReceiveCertificationNumber() }
    case .checkCertificationNumber:
      Task { await handleCheckCertificationNumber() }
    case .tapNextButton:
      tapNextButtonFlag = true
    }
  }
  
  private func buttonType(for isEnabled: Bool) -> RoundedButton.ButtonType {
    isEnabled ? .solid : .disabled
  }
  
  private func handleReceiveCertificationNumber() async {
    verificationFieldInfoText = "어떤 경우에도 타인에게 공유하지 마세요"
    verrificationFieldInfoTextColor = .grayscaleDark3
    do {
      _ = try await sendSMSCodeUseCase.execute(phoneNumber: phoneNumber)
    } catch {
      print(error.localizedDescription)
    }
    await MainActor.run {
      recivedCertificationNumberButtonText = "인증번호 재전송"
      recivedCertificationNumberButtonWidth = Constants.buttonExpandedWidth
      startTimer()
      showVerificationField = true
    }
  }
  
  private func handleCheckCertificationNumber() async {
    do {
      print(phoneNumber, verificationCode)
      let response = try await verifySMSCodeUseCase.execute(phoneNumber: phoneNumber, code: verificationCode)
      if let accessToken = response.accessToken {
        PCKeychainManager.shared.save(.accessToken, value: accessToken)
      }
      if let refreshToken = response.refreshToken {
        PCKeychainManager.shared.save(.refreshToken, value: refreshToken)
      }
      if response.isPhoneNumberDuplicated {
        if let oauthProviderName = response.oauthProvider {
          self.oauthProviderName = oauthProviderName.description
        }
        showDuplicatePhoneNumberAlert = true
      }
      
      await MainActor.run {
        isPhoneVerificationCompleted = true
        verificationFieldInfoText = "전화번호 인증을 완료했어요"
        verrificationFieldInfoTextColor = .primaryDefault
      }
    } catch {
      verificationFieldInfoText = "올바른 인증번호가 아니에요"
      verrificationFieldInfoTextColor = .systemError
      print(error.localizedDescription)
    }
  }
  
  private func handleScenePhase(for scenePhase: ScenePhase) {
    switch scenePhase {
    case .background:
      pauseTimerIfNeeded()
    case .active:
      resumeTimerIfNeeded()
    default:
      break
    }
  }
  
  private func startTimer() {
    timeRemaining = Constants.initialTime
    stopTimer()
    
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      
      if self.timeRemaining > 0 {
        self.timeRemaining -= 1
      } else {
        self.stopTimer()
        verificationFieldInfoText = "유효시간이 지났어요! ‘인증번호 재전송’을 눌러주세요"
        verrificationFieldInfoTextColor = .systemError
      }
    }
  }
  
  private func stopTimer() {
    timer?.invalidate()
    timer = nil
  private func pauseTimerIfNeeded() {
  }
  private func resumeTimerIfNeeded() {
  }
  }
  
  deinit {
    stopTimer()
  }
}
