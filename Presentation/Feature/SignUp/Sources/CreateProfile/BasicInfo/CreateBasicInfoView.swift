//
//  CreateBasicInfo.swift
//  SignUp
//
//  Created by eunseou on 1/30/25.
//

import SwiftUI
import DesignSystem
import _PhotosUI_SwiftUI
import Entities
import UseCases

struct CreateBasicInfoView: View {
  @State var viewModel: CreateBasicInfoViewModel
  @FocusState private var focusField: String?
  var didTapNextButton: () -> Void
  
  init(
    profileCreator: ProfileCreator,
    checkNicknameUseCase: CheckNicknameUseCase,
    uploadProfileImageUseCase: UploadProfileImageUseCase,
    didTapNextButton: @escaping () -> Void
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        profileCreator: profileCreator,
        checkNicknameUseCase: checkNicknameUseCase,
        uploadProfileImageUseCase: uploadProfileImageUseCase
      )
    )
    self.didTapNextButton = didTapNextButton
  }
  
  var body: some View {
    ZStack {
      VStack {
        ScrollViewReader { proxy in
          ScrollView {
            VStack(alignment: .center, spacing: 32) {
              title
              
              // 프로필 이미지
              Button {
                viewModel.isProfileImageSheetPresented = true
              } label: {
                profileImage
              }
              .actionSheet(isPresented: $viewModel.isProfileImageSheetPresented) {
                ActionSheet(
                  title: Text("프로필 사진 선택"),
                  buttons: [
                    .default(Text("카메라")) { viewModel.handleAction(.selectCamera) },
                    .default(Text("앨범")) { viewModel.handleAction(.selectPhotoLibrary) },
                    .cancel(Text("취소"))
                  ]
                )
              }
              .fullScreenCover(isPresented: $viewModel.isCameraPresented) {
                CameraPicker {
                  viewModel.setImageFromCamera($0)
                }
              }
              .photosPicker(
                isPresented: $viewModel.isPhotoSheetPresented,
                selection: Binding(
                  get: { viewModel.selectedItem },
                  set: {
                    viewModel.selectedItem = $0
                    Task { await viewModel.loadImage() }
                  }
                ),
                matching: .images
              )
              // 닉네임
              nicknameTextField.id("nickname_scroll")
              
              // 나를 표현하는 한 마디
              descriptionTextField.id("description_scroll")
              
              // 생년월일
              birthdateTextField.id("birthdate_scroll")
              
              // 활동지역
              locationTextField.id("location_scroll")
              
              //키
              heightTextField.id("height_scroll")
              
              // 몸무게
              weightTextField.id("weight_scroll")
              
              // 직업
              jobTextField.id("job_scroll")
              
              // 흡연
              smokingTextField
              
              // SNS
              snsTextField
              
              // 연락처
              contactsTextField
              
              Button {
                focusField = nil
                viewModel.isSNSSheetPresented = true
              } label: {
                HStack(spacing: 4) {
                  Text("연락처 추가하기")
                    .pretendard(.body_M_M)
                  DesignSystemAsset.Icons.plusLine20.swiftUIImage
                    .renderingMode(.template)
                }
                .foregroundStyle(Color.primaryDefault)
              }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
            .background(
              Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                  focusField = nil
                }
            )
          }
          .scrollIndicators(.hidden)
          .onChange(of: focusField) { _, newValue in
            withAnimation {
              if let field = newValue {
                proxy.scrollTo("\(field)_scroll", anchor: .center)
              }
            }
          }
        }
        
        nextButton
          .padding(.horizontal, 20)
          .padding(.bottom, 10)
      }
      .ignoresSafeArea(.keyboard)
      
      if viewModel.isJobSheetPresented {
        jobBottomSheet
      }
      if viewModel.isLocationSheetPresented {
        locationBottomSheet
      }
      if viewModel.isSNSSheetPresented || viewModel.isContactTypeChangeSheetPresented {
        snsBottomSheet
      }
      VStack {
        Spacer()
        if viewModel.showToast {
          toast
            .padding(.bottom, 84)
            .opacity(viewModel.showToast ? 1 : 0)
            .animation(.easeInOut(duration: 0.5), value: viewModel.showToast)
        }
      }
    }
  }
  
  private var title: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("간단한 정보로\n당신을 표현하세요")
        .pretendard(.heading_L_SB)
        .foregroundStyle(Color.grayscaleBlack)
      Text("작성 후에도 언제든 수정 가능하니,\n편안하게 작성해 주세요.")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark3)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.bottom, 8)
    .padding(.top, 20)
  }
  
  private var profileImage: some View {
    Group {
      if let image = viewModel.profileImage {
        Image(uiImage: image)
          .resizable()
          .scaledToFill()
          .frame(width: 120, height: 120)
          .clipShape(Circle())
      } else {
        DesignSystemAsset.Images.profileImageNodata.swiftUIImage
      }
    }
    .overlay(alignment: .bottomTrailing) {
      DesignSystemAsset.Icons.plus24.swiftUIImage
        .renderingMode(.template)
        .foregroundStyle(Color.grayscaleWhite)
        .background(
          Circle()
            .frame(width: 33, height: 33)
            .foregroundStyle(Color.primaryDefault)
            .overlay(
              Circle()
                .stroke(Color.white, lineWidth: 3)
            )
        )
    }
    .padding(.bottom, 8)
  }
  
  private var nicknameTextField: some View {
    PCTextField(
      title: "닉네임",
      text: $viewModel.nickname,
      focusState: $focusField,
      focusField: "nickname",
      placeholder: "6자 이하로 작성해 주세요"
    )
    .withButton(
      RoundedButton(
        type: .solid,
        buttonText: "중복검사",
        width: .maxWidth,
        action: { viewModel.handleAction(.tapVaildNickName)}
      )
    )
    .infoText(
      viewModel.nicknameInfoText,
      color: viewModel.nicknameInfoTextColor
    )
    .textMaxLength(6)
    .onSubmit {
      focusField = "description"
    }
  }
  
  private var descriptionTextField: some View {
    PCTextField(
      title: "나를 표현하는 한 마디",
      text: $viewModel.description,
      focusState: $focusField,
      focusField: "description",
      placeholder: "수식어 형태로 작성해 주세요"
    )
    .infoText(
      viewModel.descriptionInfoText,
      color: .systemError
    )
    .textMaxLength(20)
    .onSubmit {
      focusField = "birthDate"
    }
  }
  
  private var birthdateTextField: some View {
    PCTextField(
      title: "생년월일",
      text: $viewModel.birthDate,
      focusState: $focusField,
      focusField: "birthDate",
      placeholder: "8자리(YYYYMMDD) 형식으로 입력해 주세요"
    )
    .infoText(
      viewModel.birthDateInfoText,
      color: .systemError
    )
    .onChange { newValue in
      viewModel.birthDate = String(newValue.filter { $0.isNumber }.prefix(8))
    }
    .textContentType(.birthdate)
    .keyboardType(.numberPad)
  }
  
  private var locationTextField: some View {
    PCTextField(
      title: "활동지역",
      text: $viewModel.location,
      focusState: $focusField,
      focusField: "location"
    )
    .rightImage(DesignSystemAsset.Icons.chevronDown24.swiftUIImage)
    .infoText( viewModel.locationInfoText,
               color: .systemError
    )
    .disabled(true)
    .onTapGesture {
      focusField = nil
      viewModel.isLocationSheetPresented = true
    }
  }
  
  private var heightTextField: some View {
    PCTextField(
      title: "키",
      text: $viewModel.height,
      focusState: $focusField,
      focusField: "height"
    )
    .rightText("cm")
    .infoText(viewModel.heightInfoText,
              color: .systemError
    )
    .onChange { newValue in
      viewModel.height = newValue.filter { $0.isNumber }
    }
    .keyboardType(.numberPad)
  }
  
  private var weightTextField: some View {
    PCTextField(
      title: "몸무게",
      text: $viewModel.weight,
      focusState: $focusField,
      focusField: "weight"
    )
    .rightText("kg")
    .infoText( viewModel.weightInfoText,
               color: .systemError
    )
    .onChange { newValue in
      viewModel.weight = newValue.filter { $0.isNumber }
    }
    .keyboardType(.numberPad)
  }
  
  private var jobTextField: some View {
    PCTextField(
      title: "직업",
      text: $viewModel.job,
      focusState: $focusField,
      focusField: "job"
    )
    .rightImage(DesignSystemAsset.Icons.chevronDown24.swiftUIImage)
    .infoText(
      viewModel.jobInfoText,
      color: .systemError
    )
    .disabled(true)
    .onTapGesture {
      focusField = nil
      viewModel.isJobSheetPresented = true
    }
  }
  
  private var smokingTextField: some View {
    VStack(alignment: .leading) {
      Text("흡연")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark3)
      HStack {
        SelectCard(isEditing: true, isSelected: viewModel.smokingStatus == "흡연", text: "흡연") {
          viewModel.smokingStatus = "흡연"
          focusField = nil
        }
        SelectCard(isEditing: true, isSelected: viewModel.smokingStatus == "비흡연", text: "비흡연") {
          viewModel.smokingStatus = "비흡연"
          focusField = nil
        }
      }
      Text( viewModel.smokingInfoText)
        .pretendard(.body_S_M)
        .foregroundStyle(Color.systemError)
    }
  }
  
  private var snsTextField: some View {
    VStack(alignment: .leading) {
      Text("SNS")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark3)
      HStack {
        SelectCard(
          isEditing: true,
          isSelected: viewModel.snsActivityLevel == "활동",
          text: "활동"
        ) {
          viewModel.snsActivityLevel = "활동"
        }
        SelectCard(
          isEditing: true,
          isSelected: viewModel.snsActivityLevel == "은둔",
          text: "은둔"
        ){
          viewModel.snsActivityLevel = "은둔"
        }
      }
      Text(viewModel.snsInfoText)
        .pretendard(.body_S_M)
        .foregroundStyle(Color.systemError)
    }
  }
  
  private var contactsTextField: some View {
    VStack(alignment: .leading) {
      Text("연락처")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark3)
      ForEach(viewModel.contacts, id: \.id) { contact in
        PCTextEditor(
          text: Binding(
            get: { contact.value },
            set: { newValue in
              if let index = viewModel.contacts.firstIndex(where: { $0.id == contact.id }) {
                viewModel.contacts[index].value = newValue
              }
            }
          ),
          image: iconFor(contactType: contact.type),
          showDeleteButton: viewModel.contacts.first != contact,
          tapDeleteButton: {
            if let index = viewModel.contacts.firstIndex(where: { $0.id == contact.id }) {
              viewModel.removeContact(at: index)
            }
          },
          action: {
            focusField = nil
            viewModel.selectedContactForIconChange = contact
            viewModel.isContactTypeChangeSheetPresented = true
          }
        )
      }
    }
  }
  
  private var nextButton: some View {
    RoundedButton(
      type: .solid,
      buttonText: "다음",
      width: .maxWidth,
      action: {
        viewModel.handleAction(.tapNextButton)
        if viewModel.isNextButtonEnabled {
          didTapNextButton()
        }
      }
    )
  }
  
  private var locationBottomSheet: some View {
    PCBottomSheet(
      isPresented: $viewModel.isLocationSheetPresented,
      height: 623,
      titleText: "활동지역 선택",
      buttonText: "저장하기",
      buttonAction: { viewModel.saveSelectedLocation() }
    ) {
      VStack {
        ScrollView{
          ForEach(viewModel.locations, id: \.self) { location in
            cellItem(
              text: location,
              isSelected: viewModel.selectedLocation == location || viewModel.location == location,
              action: { viewModel.selectedLocation = location }
            )
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }
  
  private var jobBottomSheet: some View {
    PCBottomSheet(
      isPresented: $viewModel.isJobSheetPresented,
      height: 431,
      titleText: "직업 선택",
      buttonText: "저장하기",
      buttonAction: {  viewModel.saveSelectedJob() }
    ) {
      ScrollView{
        VStack(alignment: .leading) {
          ForEach(viewModel.jobs, id: \.self) { job in
            cellItem(
              text: job,
              isSelected: viewModel.selectedJob == job || viewModel.job == job,
              action: { viewModel.selectedJob = job }
            )
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
  
  private var snsBottomSheet: some View {
    PCBottomSheet(
      isPresented:  Binding(
        get: { viewModel.isSNSSheetPresented || viewModel.isContactTypeChangeSheetPresented },
        set: { isPresented in
          viewModel.isSNSSheetPresented = isPresented
          viewModel.isContactTypeChangeSheetPresented = isPresented
        }
      ),
      height: 479,
      titleText: "연락처 추가",
      buttonText: "추가하기",
      buttonAction: {
        viewModel.saveSelectedSNSItem()
      }
    ) {
      VStack {
        ScrollView{
          VStack(alignment: .leading) {
            cellItem(
              image: DesignSystemAsset.Icons.kakao32.swiftUIImage,
              text: "카카오톡 아이디",
              isSelected: viewModel.selectedSNSContactType == .kakao,
              action: { viewModel.selectedSNSContactType = .kakao  }
            )
            cellItem(
              image: DesignSystemAsset.Icons.kakaoOpenchat32.swiftUIImage,
              text: "카카오톡 오픈 채팅방",
              isSelected: viewModel.selectedSNSContactType == .openKakao,
              action: { viewModel.selectedSNSContactType = .openKakao }
            )
            cellItem(
              image: DesignSystemAsset.Icons.instagram32.swiftUIImage,
              text: "인스타 아이디",
              isSelected: viewModel.selectedSNSContactType == .instagram,
              action: { viewModel.selectedSNSContactType = .instagram }
            )
            cellItem(
              image: DesignSystemAsset.Icons.cellFill32.swiftUIImage,
              text: "전화번호",
              isSelected: viewModel.selectedSNSContactType == .phone,
              action: { viewModel.selectedSNSContactType = .phone }
            )
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }
  
  private func iconFor(contactType: ContactModel.ContactType) -> Image {
    switch contactType {
    case .kakao:
      return DesignSystemAsset.Icons.kakao32.swiftUIImage
    case .openKakao:
      return DesignSystemAsset.Icons.kakaoOpenchat32.swiftUIImage
    case .instagram:
      return DesignSystemAsset.Icons.instagram32.swiftUIImage
    case .phone:
      return DesignSystemAsset.Icons.cellFill32.swiftUIImage
    default:
      return Image(systemName: "questionmark")
    }
  }
  
  private func cellItem(
    image: Image? = nil,
    text: String,
    isSelected: Bool = false,
    action: @escaping () -> Void
  ) -> some View {
    Button(action: action) {
      HStack {
        if let image {
          image
            .renderingMode(.template)
            .foregroundStyle(isSelected ? Color.primaryDefault : Color.grayscaleBlack)
        }
        Text(text)
          .pretendard(.body_M_M)
          .foregroundStyle(isSelected ? Color.primaryDefault : Color.grayscaleBlack)
        Spacer()
        if isSelected {
          DesignSystemAsset.Icons.check24.swiftUIImage
            .renderingMode(.template)
            .foregroundStyle(Color.primaryDefault)
        }
      }
      .padding(.vertical, 12)
      .frame(maxWidth: .infinity)
    }
  }
  
  private var toast: some View {
    HStack {
      DesignSystemAsset.Icons.notice20.swiftUIImage
        .renderingMode(.template)
      Text("모든 항목을 작성해 주세요")
        .pretendard(.body_S_M)
    }
    .foregroundStyle(Color.grayscaleWhite)
    .padding(.vertical, 8)
    .padding(.horizontal, 20)
    .background(
      Rectangle()
        .foregroundStyle(Color.grayscaleDark2)
        .cornerRadius(12)
    )
  }
}

//#Preview {
//  CreateBasicInfoView()
//}
