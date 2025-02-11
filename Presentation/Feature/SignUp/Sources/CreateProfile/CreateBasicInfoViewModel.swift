//
//  CreateBasicInfoViewModel.swift
//  SignUp
//
//  Created by eunseou on 2/1/25.
//

import SwiftUI
import Observation
import UseCases

@Observable
final class CreateBasicInfoViewModel {
  enum Action {
    case tapNextButton
    case selectCamera
    case selectPhotoLibrary
  }
  
  var nickname: String = ""
  var description: String = ""
  var birthDate: String = ""
  var location: String = ""
  var height: String = ""
  var weight: String = ""
  var job: String = ""
  var contact: String = ""
  
  var isJobSheetPresented: Bool = false
  var isLocationSheetPresented: Bool = false
  var isSNSSheetPresented: Bool = false
  var isPhotoSheetPresented: Bool = false
  var showToast: Bool = false
  
  var showNicknameError: Bool = false
  var showIntroductionError: Bool = false
  var showBirthDateError: Bool = false
  var showLocationError: Bool = false
  var showHeightError: Bool = false
  var showWeightError: Bool = false
  var showJobError: Bool = false
  var showSmokingError: Bool = false
  var showSNSError: Bool = false
  var showContactError: Bool = false
  var showAdditionalContactError: Bool = false
  
  var smokingStatus: String = ""
  var snsActivityLevel: String = ""
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapNextButton:
      handleTapNextButton()
    case .selectCamera:
      print("카메라 선택")
    case .selectPhotoLibrary:
      print("앨범 선택")
    }
  }
  
  private func handleTapNextButton() {
    if nickname.isEmpty || description.isEmpty || birthDate.isEmpty || location.isEmpty || height.isEmpty || weight.isEmpty || job.isEmpty || contact.isEmpty {
      showToast = true
    }
  }
}
