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
import _PhotosUI_SwiftUI
import Entities

@Observable
final class CreateBasicInfoViewModel {
  enum Action {
    case tapNextButton
    case selectCamera
    case selectPhotoLibrary
  }
  
  // TextField Bind
  var profileImage: UIImage? = nil
  var nickname: String = ""
  var description: String = ""
  var birthDate: String = ""
  var location: String = ""
  var height: String = ""
  var weight: String = ""
  var job: String = ""
  var contacts: [ContactModel] = [ContactModel(type: .kakao, value: "")]
  
  // isValid
  var isValidProfileImage: Bool = false
  var isDescriptionValid: Bool {
    !description.isEmpty && description.count <= 20
  }
  var selectedItem: PhotosPickerItem? = nil
  var didTapnextButton: Bool = false
  
  // TextField InfoMessage
  var nicknameInfoText: String {
    if nickname.isEmpty && didTapnextButton {
      return "필수 항목을 입력해 주세요."
    } else if nickname.count > 6 {
      return "6자 이하로 작성해 주세요."
    } else {
      return ""
    }
  }
  var nicknameInfoTextColor: Color = Color.systemError
  var descriptionInfoText: String {
    if description.isEmpty && didTapnextButton {
      return "필수 항목을 입력해 주세요."
    } else if description.count > 20 {
      return "20자 이하로 작성해 주세요."
    } else {
      return ""
    }
  }
  var birthDateInfoText: String {
    if birthDate.isEmpty && didTapnextButton {
      return "필수 항목을 입력해 주세요."
    } else {
      return ""
    }
  }
  var locationInfoText: String {
    if location.isEmpty && didTapnextButton {
      return "필수 항목을 입력해 주세요."
    } else {
      return ""
    }
  }
  var heightInfoText: String {
    if height.isEmpty && didTapnextButton {
      return "필수 항목을 입력해 주세요."
    } else {
      return ""
    }
  }
  var weightInfoText: String {
    if weight.isEmpty && didTapnextButton {
      return "필수 항목을 입력해 주세요."
    } else {
      return ""
    }
  }
  var jobInfoText: String {
    if job.isEmpty && didTapnextButton {
      return "필수 항목을 입력해 주세요."
    } else {
      return ""
    }
  }
  var smokingInfoText: String {
    if smokingStatus.isEmpty && didTapnextButton {
      return "필수 항목을 입력해 주세요."
    } else {
      return ""
    }
  }
  var snsInfoText: String {
    if snsActivityLevel.isEmpty && didTapnextButton {
      return "필수 항목을 입력해 주세요."
    } else {
      return ""
    }
  }
  var contactInfoText: String = ""
  var showAdditionalContactError: Bool = false
  
  // temp
  var smokingStatus: String = ""
  var snsActivityLevel: String = ""
  var selectedLocation: String? = nil
  var selectedJob: String? = nil
  var selectedSNSContactType: ContactModel.ContactType? = nil
  
  var locations: [String] = ["서울특별시", "경기도", "부산광역시", "대전광역시", "울산광역시", "세종특별자치시", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주특별자치도", "기타"]
  var jobs: [String] = ["학생", "직장인", "전문직", "사업가", "프리랜서", "기타"]
  
  // Sheet
  var isPhotoSheetPresented: Bool = false
  var isCameraPresented: Bool  = false
  var isJobSheetPresented: Bool = false
  var isLocationSheetPresented: Bool = false
  var isSNSSheetPresented: Bool = false
  var isProfileImageSheetPresented: Bool = false
  var showToast: Bool = false
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapNextButton:
      Task {
        await handleTapNextButton()
      }
    case .selectCamera:
      isCameraPresented = true
    case .selectPhotoLibrary:
      isPhotoSheetPresented = true
    }
  }
  
  private func handleTapNextButton() async {
    if nickname.isEmpty || description.isEmpty || birthDate.isEmpty || location.isEmpty || height.isEmpty || weight.isEmpty || job.isEmpty || contacts.isEmpty {
      didTapnextButton = true
      await isToastVisible()
    }
  }
  
  @MainActor
  private func isToastVisible() async {
    showToast = true
    try? await Task.sleep(for: .seconds(3))
    showToast = false
  }
  
  func saveSelectedJob() {
    if let selectedJob = selectedJob {
      self.job = selectedJob
    }
    isJobSheetPresented = false
  }
  
  func saveSelectedLocation() {
    if let selectedLocation = selectedLocation {
      self.location = selectedLocation
    }
    isLocationSheetPresented = false
  }
  
  func saveSelectedSNSItem() {
    guard let selectedType = selectedSNSContactType else {
      return
    }
    contacts.append(ContactModel(type: selectedType, value: ""))
    isSNSSheetPresented = false
    selectedSNSContactType = nil
  }
  
  func removeContact(at index: Int) {
    func removeContact(_ contact: ContactModel) {
        guard contacts.count > 1 else { return } // 최소 1개는 유지
        contacts.removeAll { $0.id == contact.id }
    }
  }
  
  func loadImage() async {
    guard let selectedItem else {
      print("선택된 아이템이 없습니다.")
      return
    }
    
    do {
      if let data = try await selectedItem.loadTransferable(type: Data.self),
         let image = UIImage(data: data) {
        self.profileImage = image  // UIImage로 저장
      } else {
        print("이미지 데이터를 로드할 수 없습니다.")
      }
    } catch {
      print("이미지 로드 중 오류 발생: \(error.localizedDescription)")
    }
  }
  
  func setImageFromCamera(_ image: UIImage) {
    self.profileImage = image
  }
}
