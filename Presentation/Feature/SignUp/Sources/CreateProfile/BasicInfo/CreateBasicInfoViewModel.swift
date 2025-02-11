//
//  CreateBasicInfoViewModel.swift
//  SignUp
//
//  Created by eunseou on 2/1/25.
//

import SwiftUI
import Observation
import UseCases
import DesignSystem

enum SNSContactType: String, CaseIterable {
  case kakao
  case kakaoOpenChat
  case instagram
  case phone
  
  var icon: Image {
    switch self {
    case .kakao:
      return DesignSystemAsset.Icons.kakao32.swiftUIImage
    case .kakaoOpenChat:
      return DesignSystemAsset.Icons.kakaoOpenchat32.swiftUIImage
    case .instagram:
      return DesignSystemAsset.Icons.instagram32.swiftUIImage
    case .phone:
      return DesignSystemAsset.Icons.cellFill32.swiftUIImage
    }
  }
  
  var placeholder: String {
    switch self {
    case .kakao:
      return "카카오톡 아이디"
    case .kakaoOpenChat:
      return "카카오톡 오픈 채팅방"
    case .instagram:
      return "인스타 아이디"
    case .phone:
      return "전화번호"
    }
  }
}

struct SNSContact: Identifiable {
  let id = UUID()
  let icon: Image
  let placeholder: String
}

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
  var contacts: [String] = [""]
  
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
  
  var jobs: [String] = ["서울특별시", "경기도", "부산광역시", "대전광역시", "울산광역시", "세종특별자치시", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주특별자치도", "기타"]
  var locations: [String] = ["학생", "직장인", "전문직", "사업가", "프리랜서", "기타"]
  var snsContacts: [SNSContact] = [
    SNSContact(icon: DesignSystemAsset.Icons.kakao32.swiftUIImage, placeholder: "카카오톡 아이디"),
    SNSContact(icon: DesignSystemAsset.Icons.kakaoOpenchat32.swiftUIImage, placeholder: "카카오톡 오픈 채팅방"),
    SNSContact(icon: DesignSystemAsset.Icons.instagram32.swiftUIImage, placeholder: "인스타 아이디"),
    SNSContact(icon: DesignSystemAsset.Icons.cellFill32.swiftUIImage, placeholder: "전화번호")
  ]
  
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
    if nickname.isEmpty || description.isEmpty || birthDate.isEmpty || location.isEmpty || height.isEmpty || weight.isEmpty || job.isEmpty || contacts.isEmpty {
      showToast = true
    }
  }
}
