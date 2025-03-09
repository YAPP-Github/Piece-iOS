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
    case reciveCertificationNumber
    case checkCertificationNumber
    case tapNextButton
  }
  
  private let sendSMSCodeUseCase: SendSMSCodeUseCase
  private let verifySMSCodeUseCase: VerifySMSCodeUseCase
  
  private(set) var showVerificationField: Bool = false
  private(set) var isActiveNextButton: Bool = false
  private(set) var tapNextButtonFlag: Bool = false
  private(set) var recivedCertificationNumberButtonText: String = "인증번호 받기"
  private(set) var recivedCertificationNumberButtonWidth = Constants.buttonDefaultWidth
  private var timer: Timer?
  private var timeRemaining = Constants.initialTime
  var phoneNumber: String = ""
  var verificationCode: String = ""
  var isVerificationCodeValid: Bool {
      !verificationCode.isEmpty && verificationCode.count >= 4
  }
  var isPhoneNumberValid: Bool {
      !phoneNumber.isEmpty && (phoneNumber.count == 11 || phoneNumber.count == 10)
  }
  var phoneNumberTextfieldButtonType: RoundedButton.ButtonType {
    buttonType(for: isPhoneNumberValid)
  }
  var verificationCodeTextfieldButtonType: RoundedButton.ButtonType {
    buttonType(for: isVerificationCodeValid)
  }
  var nextButtonType: RoundedButton.ButtonType {
    buttonType(for: isActiveNextButton)
  }
  var timerText: String {
    timeRemaining.formattedTime
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
      PCKeychainManager.shared.save(.accessToken, value: response.accessToken)
      PCKeychainManager.shared.save(.refreshToken, value: response.refreshToken)
      await MainActor.run {
        isActiveNextButton = true
      }
    } catch {
      print(error.localizedDescription)
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
      }
    }
  }
  
  private func stopTimer() {
    timer?.invalidate()
    timer = nil
  }
  
  deinit {
    stopTimer()
  }
}
