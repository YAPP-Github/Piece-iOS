//
//  VerifingContactViewModel.swift
//  Login
//
//  Created by eunseou on 1/11/25.
//

import SwiftUI
import Observation
import PCFoundationExtension

@Observable
final class VerifingContactViewModel {
  enum Action {
    case reciveCertificationNumber
    case checkCertificationNumber
    case tapNextButton
  }
  
  private(set) var isPhoneNumberValid: Bool = false
  private(set) var showVerificationField: Bool = false
  private(set) var isVerificationCodeValid: Bool = false
  private(set) var isActiveNextButton: Bool = false
  private(set) var recivedCertificationNumberButtonText: String = "인증번호 받기"
  private(set) var recivedCertificationNumberButtonWidth: CGFloat = 111
  private var timer: Timer?
  private var timeRemaining: Int = 300
  var phoneNumber: String = "" {
    didSet {
      isPhoneNumberValid = !phoneNumber.isEmpty && (phoneNumber.count == 11 || phoneNumber.count == 10)
    }
  }
  var verificationCode: String = "" {
    didSet {
      isVerificationCodeValid = !verificationCode.isEmpty && verificationCode.count >= 4
    }
  }
  var timerText: String {
    timeRemaining.formattedTime
  }
  
  init(
    phoneNumber: String,
    verificationCode: String
  ) {
    self.phoneNumber = phoneNumber
    self.verificationCode = verificationCode
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .reciveCertificationNumber:
      showVerificationField = true
      recivedCertificationNumberButtonText = "인증번호 재전송"
      recivedCertificationNumberButtonWidth = 125
      startTimer()
    case .checkCertificationNumber:
      isActiveNextButton = true
    case .tapNextButton:
      return
    }
  }
  
  private func startTimer() {
    timeRemaining = 300
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
