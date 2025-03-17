//
//  ProfileEditViewModel.swift
//  ProfileEdit
//
//  Created by eunseou on 3/18/25.
//

import SwiftUI
import Observation
import UseCases
import DesignSystem
import _PhotosUI_SwiftUI
import Entities
import PCFoundationExtension

@Observable
final class ProfileEditViewModel {
  enum Action {
    case tapNextButton
    case tapVaildNickName
    case selectCamera
    case selectPhotoLibrary
  }
  
  init(
    checkNicknameUseCase: CheckNicknameUseCase,
    uploadProfileImageUseCase: UploadProfileImageUseCase
  ) {
    self.checkNicknameUseCase = checkNicknameUseCase
    self.uploadProfileImageUseCase = uploadProfileImageUseCase
  }
  
  private let checkNicknameUseCase: CheckNicknameUseCase
  private let uploadProfileImageUseCase: UploadProfileImageUseCase
  
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
  var isValidNickname: Bool = false
  var isDescriptionValid: Bool {
    !description.isEmpty && description.count <= 20
  }
  var isValidBirthDate: Bool { isValidBirthDateFormat(birthDate) }
  var isContactsValid: Bool {
    return contacts.allSatisfy { !$0.value.isEmpty }
  }
  var isNextButtonEnabled: Bool {
    return isValidProfileImage &&
    didCheckDuplicates && isValidNickname &&
    isValidBirthDate &&
    !nickname.isEmpty &&
    !description.isEmpty &&
    !birthDate.isEmpty &&
    !location.isEmpty &&
    !height.isEmpty &&
    !weight.isEmpty &&
    !job.isEmpty &&
    isContactsValid
  }
  
  // TextField InfoMessage
  var nicknameInfoText: String {
    if nickname.isEmpty && didTapnextButton {
      return "필수 항목을 입력해 주세요."
    } else if nickname.count > 6 {
      return "6자 이하로 작성해 주세요."
    } else if didCheckDuplicates && !isValidNickname {
      return "이미 사용 중인 닉네임입니다."
    } else if didCheckDuplicates && isValidNickname {
      return "사용할 수 있는 닉네임입니다."
    } else {
      return ""
    }
  }
  var nicknameInfoTextColor: Color  {
    if didCheckDuplicates && isValidNickname {
      return Color.primaryDefault
    } else {
      return Color.systemError
    }
  }
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
    } else if !birthDate.isEmpty && !isValidBirthDateFormat(birthDate) {
      return "생년월일은 YYYYMMDD 형식으로 입력해 주세요."
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
  var customJobText: String = ""
  var customLocationText: String = ""
  var isCustomJobSelected: Bool = false
  var isCustomLocationSelected: Bool = false
  var selectedSNSContactType: ContactModel.ContactType? = nil
  var selectedContactForIconChange: ContactModel? = nil
  var isContactTypeChangeSheetPresented: Bool = false
  var selectedItem: PhotosPickerItem? = nil
  var didCheckDuplicates: Bool = false
  var didTapnextButton: Bool = false
  
  var locations: [String] = ["서울특별시", "경기도", "부산광역시", "대전광역시", "울산광역시", "세종특별자치시", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주특별자치도", "기타"]
  var jobs: [String] = ["학생", "직장인", "전문직", "사업가", "프리랜서", "기타"]
  
  // Sheet
  var isPhotoSheetPresented: Bool = false
  var isCameraPresented: Bool  = false
  var isJobSheetPresented: Bool = false {
    didSet {
      if isJobSheetPresented {
        // 바텀시트가 열릴 때 현재 job이 jobs 배열에 없다면 custom으로 간주
        if !jobs.contains(job) && !job.isEmpty {
          isCustomJobSelected = true
          selectedJob = nil
          customJobText = job
        } else {
          isCustomJobSelected = false
          selectedJob = job
          customJobText = ""
        }
      }
    }
  }
  var isLocationSheetPresented: Bool = false {
    didSet {
      if isLocationSheetPresented {
        if !locations.contains(location) && !location.isEmpty {
          isCustomLocationSelected = true
          selectedLocation = nil
          customLocationText = location
        } else {
          isCustomLocationSelected = false
          selectedLocation = location
          customLocationText = ""
        }
      }
    }
  }
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
    case .tapVaildNickName:
      Task {
        await handleTapVaildNicknameButton()
      }
    }
  }
  
  private func handleTapNextButton() async {
    print("isNextButtonEnabled: \(isNextButtonEnabled)")
    
    if profileImage == nil || nickname.isEmpty || description.isEmpty || birthDate.isEmpty || location.isEmpty || height.isEmpty || weight.isEmpty || job.isEmpty || !isContactsValid {
      didTapnextButton = true
      await isToastVisible()
    } else if isNextButtonEnabled {
      do {
        guard let profileImage = profileImage else { return }
        guard let imageData = profileImage.resizedAndCompressedData(targetSize: CGSize(width: 400, height: 400), compressionQuality: 0.5) else {
          print("이미지 데이터 변환 실패")
          return
        }
        
        let imageURL = try await uploadProfileImageUseCase.execute(image: imageData)
        print("이미지 업로드 성공: \(imageURL)")
        
        let basicInfo = ProfileBasicModel(
          nickname: nickname,
          description: description,
          birthdate: birthDate,
          height: Int(height) ?? 0,
          weight: Int(weight) ?? 0,
          job: job,
          location: location,
          smokingStatus: smokingStatus,
          snsActivityLevel: snsActivityLevel,
          imageUri: imageURL.absoluteString,
          contacts: contacts
        )
        
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  private func handleTapVaildNicknameButton() async {
    isValidNickname = (try? await checkNicknameUseCase.execute(nickname: nickname)) ?? false
    didCheckDuplicates = true
  }
  
  @MainActor
  private func isToastVisible() async {
    showToast = true
    try? await Task.sleep(for: .seconds(3))
    showToast = false
  }
  
  private func isValidBirthDateFormat(_ date: String) -> Bool {
    let dateRegex = "^[0-9]{8}$" // YYYYMMDD
    let dateTest = NSPredicate(format: "SELF MATCHES %@", dateRegex)
    return dateTest.evaluate(with: date) && date.count == 8
  }
  
  func saveSelectedJob() {
    if isCustomJobSelected {
      self.job = customJobText.isEmpty ? "" : customJobText
    } else if let selectedJob = selectedJob {
      self.job = selectedJob
    }
    isJobSheetPresented = false
    selectedJob = nil
    customJobText = ""
    isCustomJobSelected = false
  }
  
  func saveSelectedLocation() {
    if isCustomLocationSelected {
      self.location = customLocationText.isEmpty ? "" : customLocationText
    } else if let selectedLocation = selectedLocation {
      self.location = selectedLocation
    }
    isLocationSheetPresented = false
    selectedLocation = nil
    customLocationText = ""
    isCustomLocationSelected = false
  }
  
  func updateContactType(for contact: ContactModel, newType: ContactModel.ContactType) {
    if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
      contacts[index].type = newType
    }
  }
  
  func saveSelectedSNSItem() {
    if let selectedType = selectedSNSContactType {
      if let contact = selectedContactForIconChange {
        // 아이콘 변경 시 처리
        updateContactType(for: contact, newType: selectedType)
      } else {
        // 새 연락처 추가 시 처리
        contacts.append(ContactModel(type: selectedType, value: ""))
      }
    }
    
    // 상태 초기화
    isSNSSheetPresented = false
    isContactTypeChangeSheetPresented = false
    selectedSNSContactType = nil
    selectedContactForIconChange = nil
  }
  
  func removeContact(at index: Int) {
    guard contacts.indices.contains(index), index != 0 else { return }
    contacts.remove(at: index)
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
        self.isValidProfileImage = true
      } else {
        print("이미지 데이터를 로드할 수 없습니다.")
      }
    } catch {
      print("이미지 로드 중 오류 발생: \(error.localizedDescription)")
    }
  }
  
  func setImageFromCamera(_ image: UIImage) {
    self.profileImage = image
    self.isValidProfileImage = true
  }
}
