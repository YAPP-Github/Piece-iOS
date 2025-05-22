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

@MainActor
@Observable
final class EditProfileViewModel {
  enum Action {
    case tapConfirmButton
    case tapVaildNickName
    case selectCamera
    case selectPhotoLibrary
    case tapLocation
    case tapJob
    case tapAddContact
    case tapChangeContact(ContactModel)
    case saveLocation
    case saveJob
    case saveContact
    case editContact
  }
  
  init(
    getProfileBasicUseCase: GetProfileBasicUseCase,
    updateProfileBasicUseCase: UpdateProfileBasicUseCase,
    checkNicknameUseCase: CheckNicknameUseCase,
    uploadProfileImageUseCase: UploadProfileImageUseCase
  ) {
    self.updateProfileBasicUseCase = updateProfileBasicUseCase
    self.getProfileBasicUseCase = getProfileBasicUseCase
    self.checkNicknameUseCase = checkNicknameUseCase
    self.uploadProfileImageUseCase = uploadProfileImageUseCase
    
    Task {
      await getBasicProfile()
    }
  }
  
  private let updateProfileBasicUseCase: UpdateProfileBasicUseCase
  private let getProfileBasicUseCase: GetProfileBasicUseCase
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
  var isValidNickname: Bool = true
  var isDescriptionValid: Bool {
    !description.isEmpty && description.count <= 20
  }
  var isValidBirthDate: Bool { isValidBirthDateFormat(birthDate) }
  var isValidHeight: Bool {
    (2...3).contains(height.count) && height.allSatisfy(\.isNumber)
  }
  var isVaildWeight: Bool {
    (2...3).contains(weight.count) && weight.allSatisfy(\.isNumber)
  }
  var isContactsValid: Bool {
    return contacts.allSatisfy { !$0.value.isEmpty }
  }
  var isNextButtonEnabled: Bool {
    return isValidProfileImage &&
    didCheckDuplicates && isValidNickname &&
    !nickname.isEmpty &&
    !description.isEmpty &&
    isValidBirthDate &&
    !location.isEmpty &&
    isValidHeight &&
    isVaildWeight &&
    !job.isEmpty &&
    isContactsValid &&
    !isEditingNickName
  }
  var isEditing: Bool = false {
    didSet {
      print("isEditing 상태 변경: \(isEditing)")
    }
  }
  var isEditingNickName: Bool = false
  var navigationItemColor: Color {
    isEditing ? .primaryDefault : .grayscaleDark3
  }
  
  // TextField InfoMessage
  var nicknameInfoText: String {
    if !isEditingNickName {
      return ""
    } else if nickname.isEmpty && didTapnextButton {
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
    } else if !height.isEmpty && !((2...3).contains(height.count) && height.allSatisfy(\.isNumber)) {
      return "숫자가 정확한 지 확인해 주세요."
    } else {
      return ""
    }
  }
  var weightInfoText: String {
    if weight.isEmpty && didTapnextButton {
      return "필수 항목을 입력해 주세요."
    } else if !weight.isEmpty && !((2...3).contains(weight.count) && weight.allSatisfy(\.isNumber)) {
      return "숫자가 정확한 지 확인해 주세요."
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
  var isCustomJobSelected: Bool = false
  var selectedSNSContactType: ContactModel.ContactType? = nil
  var selectedContactForIconChange: ContactModel? = nil
  var prevSelectedContact: ContactModel? = nil
  var isContactTypeChangeSheetPresented: Bool = false
  var selectedItem: PhotosPickerItem? = nil
  var didCheckDuplicates: Bool = true
  var didTapnextButton: Bool = false
  
  var locationItems: [BottomSheetTextItem] = Locations.all.map { BottomSheetTextItem(text: $0) }
  var jobs: [String] = Jobs.all
  var jobItems: [BottomSheetTextItem] = Jobs.all.map { BottomSheetTextItem(text: $0) }
  var contactBottomSheetItems: [BottomSheetIconItem] = BottomSheetIconItem.defaultContactItems
  
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
        selectedLocation = location
      }
    }
  }
  var canAddMoreContact: Bool {
    contacts.count < Constant.contactModelCount
  }
  var isSNSSheetPresented: Bool = false
  var isProfileImageSheetPresented: Bool = false
  var showToast: Bool = false
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapConfirmButton:
      Task {
        await handleTapConfirmButton()
      }
    case .selectCamera:
      isCameraPresented = true
    case .selectPhotoLibrary:
      isPhotoSheetPresented = true
    case .tapVaildNickName:
      Task {
        await handleTapVaildNicknameButton()
      }
    case .tapLocation:
      isLocationSheetPresented = true
    case .tapJob:
      isJobSheetPresented = true
    case .tapAddContact:
      isSNSSheetPresented = true
      updateBottomSheetItems()
    case .tapChangeContact(let prevContact):
      isContactTypeChangeSheetPresented = true
      updateBottomSheetItems()
      changeBottomSheetItem(with: prevContact)
      prevSelectedContact = prevContact
    case .saveLocation:
      tapLocationBottomSheetSaveButton()
    case .saveJob:
      tapJobBottomSheetSaveButton()
    case .saveContact:
      tapContactBottomSheetSaveButton()
    case .editContact:
      tapContactBottomSheetEditButton()
    }
  }
  
  private func handleTapConfirmButton() async {
    print("isNextButtonEnabled: \(isNextButtonEnabled)")
    
    if profileImage == nil || nickname.isEmpty || description.isEmpty || birthDate.isEmpty || location.isEmpty || height.isEmpty || weight.isEmpty || job.isEmpty || !isContactsValid {
      didTapnextButton = true
      await isToastVisible()
    } else {
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
        
        _ = try await updateProfileBasicUseCase.execute(profile: basicInfo)
        isEditing = false
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  private func handleTapVaildNicknameButton() async {
    isValidNickname = (try? await checkNicknameUseCase.execute(nickname: nickname)) ?? false
    didCheckDuplicates = true
    isEditingNickName = false
  }
  
  @MainActor
  private func isToastVisible() async {
    showToast = true
    try? await Task.sleep(for: .seconds(3))
    showToast = false
  }
  
  private func isValidBirthDateFormat(_ date: String) -> Bool {
    let dateRegex = #"^(19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])$"# // YYYYMMDD
    let dateTest = NSPredicate(format: "SELF MATCHES %@", dateRegex)
    return dateTest.evaluate(with: date) && date.count == 8
  }
  
  func isAllowedInput(_ input: String) -> Bool {
      let pattern = #"^[A-Za-z0-9\s[:punct:][:symbol:]]*$"#
      guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
      let range = NSRange(location: 0, length: input.utf16.count)
      return regex.firstMatch(in: input, options: [], range: range) != nil
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
    if let selectedLocation = selectedLocation {
      self.location = selectedLocation
    }
    isLocationSheetPresented = false
    selectedLocation = nil
  }
  
  func updateContactType(for contact: ContactModel, newType: ContactModel.ContactType) {
    if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
      contacts[index] = ContactModel(type: newType, value: contact.value)
      isEditing = true
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
        isEditing = true
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
    isEditing = true
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
        self.isEditing = true
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
    self.isEditing = true
  }
  
  @MainActor
  private func getBasicProfile() async {
    do {
      let profile = try await getProfileBasicUseCase.execute()
      
      nickname = profile.nickname
      description = profile.description
      birthDate = profile.birthdate.toCompactDateString
      location = profile.location
      height = String(profile.height)
      weight = String(profile.weight)
      smokingStatus = profile.smokingStatus
      snsActivityLevel = profile.snsActivityLevel
      job = profile.job
      contacts = profile.contacts
      
      if let imageUrl = URL(string: profile.imageUri) {
        profileImage = await fetchImage(from: imageUrl)
      }
      
      isEditing = false
      isEditingNickName = false
    } catch {
      print(error.localizedDescription)
    }
  }
  
  private func fetchImage(from url: URL) async -> UIImage? {
      do {
          let (data, _) = try await URLSession.shared.data(from: url)
          return UIImage(data: data)
      } catch {
          print("이미지 다운로드 실패: \(error.localizedDescription)")
          return nil
      }
  }
}

// MARK: ContactContainer
extension EditProfileViewModel {
  func canDeleteContactField(contact: ContactModel) -> Bool {
    guard let index = contacts.firstIndex(where: { $0.id == contact.id }) else {
      return false
    }
    return index > 0
  }
  
  func removeContact(for contact: ContactModel) {
    if let index = contacts.firstIndex(where: { $0.id == contact.id }),
       index > 0 {
      removeContact(at: index)
  var isContactBottomSheetButtonEnable: Bool {
      contactBottomSheetItems.contains(where: { $0.state == .selected })
  }
}


// MARK: - Mutation

extension EditProfileViewModel {
  func changeBottomSheetItem(with targetContact: ContactModel) {
    if let contactIndex = contacts.firstIndex(where: { $0.id == targetContact.id }) {
      let targetIcon = contacts[contactIndex].type.icon
      
      if let itemIndex = contactBottomSheetItems.firstIndex(where: { $0.icon == targetIcon }) {
        contactBottomSheetItems[itemIndex].state = .selected
      }
    }
  }
  
  func updateBottomSheetItems() {
    contactBottomSheetItems = BottomSheetIconItem.defaultContactItems.map { item in
      var copy = item
      let type = ContactModel.ContactType.from(iconName: item.icon)
      
      if contacts.contains(where: { $0.type == type }) {
        copy.state = .disable
      } else {
        copy.state = .unselected
      }
      
      return copy
    }
  }
  
  func tapRowItem(_ item: any BottomSheetItemRepresentable) {
    if let index = contactBottomSheetItems.firstIndex(where: { $0.id == item.id }),
       item.state == .unselected {
      contactBottomSheetItems.enumerated().forEach { (i, item) in
        if contactBottomSheetItems[i].state == .unselected, i == index {
          contactBottomSheetItems[i].state = .selected
        } else if contactBottomSheetItems[i].state == .selected {
          contactBottomSheetItems[i].state = .unselected
        }
      }
    }
  }
  
  func tapContactBottomSheetEditButton() {
    if let prevSelectedContact,
       let selectedItem = contactBottomSheetItems.first(where: { $0.state == .selected }) {
      let newType = ContactModel.ContactType.from(iconName: selectedItem.icon)
      
      if newType != .unknown,
         let targetIndex = contacts.firstIndex(where: { $0.id == prevSelectedContact.id }) {
        let changedContact = ContactModel(type: newType, value: prevSelectedContact.value)
        contacts[targetIndex] = changedContact
      }
    }

    prevSelectedContact = nil
    isContactTypeChangeSheetPresented = false
  }

  func tapContactBottomSheetSaveButton() {
    if let selectedItem = contactBottomSheetItems.first(where: { $0.state == .selected }) {
      let newType = ContactModel.ContactType.from(iconName: selectedItem.icon)
      
      if newType != .unknown {
        let newContact = ContactModel(type: newType, value: "")
        contacts.append(newContact)
      }
    }

    isSNSSheetPresented = false
  }

  func tapLocationBottomSheetSaveButton() {
    // TODO: location 적용 로직
  }
  
  func tapJobBottomSheetSaveButton() {
    // TODO: job 적용 로직
  }
}

// MARK: Constant
extension EditProfileViewModel {
  private enum Constant {
    static let contactModelCount: Int = 4
  }
}
