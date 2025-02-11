//
//  CreateBasicInfo.swift
//  SignUp
//
//  Created by eunseou on 1/30/25.
//

import SwiftUI
import DesignSystem

struct CreateBasicInfoView: View {
  private enum Constant {
    static let textFieldInfoText: String = "필수 항목을 입력해 주세요"
  }
  @State var viewModel: CreateBasicInfoViewModel = CreateBasicInfoViewModel()
  @FocusState private var focusField: String?
  
  var body: some View {
    ZStack {
      VStack {
        ScrollView {
          VStack(alignment: .center, spacing: 32) {
            title
            
            // 프로필 이미지
            Button {
              viewModel.isPhotoSheetPresented = true
            } label: {
              profileImage
            }
            .actionSheet(isPresented: $viewModel.isPhotoSheetPresented) {
              ActionSheet(
                title: Text("프로필 사진 선택"),
                buttons: [
                  .default(Text("카메라")) { viewModel.handleAction(.selectCamera) },
                  .default(Text("앨범")) { viewModel.handleAction(.selectPhotoLibrary) },
                  .cancel()
                ]
              )
            }
            
            // 닉네임
            nicknameTextField
            
            // 나를 표현하는 한 마디
            descriptionTextField
            
            // 생년월일
            birthdateTextField
            
            // 활동지역
            locationTextField
            
            //키
            heightTextField
            
            // 몸무게
            weightTextField
            
            // 직업
            jobTextField
            
            // 흡연
            smokingTextField
            
            // SNS
            snsTextField
            
            // 연락처
            contactsTextField
            
            Button {
              viewModel.isSNSSheetPresented = true
              viewModel.contacts.append("")
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
        }
        .scrollIndicators(.hidden)
        nextButton
          .padding(.horizontal, 20)
          .padding(.bottom, 10)
      }
      
      if viewModel.isJobSheetPresented {
        jobBottomSheet
      }
      if viewModel.isLocationSheetPresented {
        locationBottomSheet
      }
      if viewModel.isSNSSheetPresented {
        snsBottomSheet
      }
      if viewModel.showToast {
        toast
        //   .transition(.move(edge: .top))
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
    DesignSystemAsset.Images.profileImageNodata.swiftUIImage
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
        action: {}
      )
    )
    .infoText(
      viewModel.showNicknameError ? Constant.textFieldInfoText : "",
      color: .systemError
    )
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
      viewModel.showIntroductionError ? Constant.textFieldInfoText : "",
      color: .systemError
    )
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
      viewModel.showBirthDateError ? Constant.textFieldInfoText : "",
      color: .systemError
    )
  }
  
  private var locationTextField: some View {
    PCTextField(
      title: "활동지역",
      text: $viewModel.location,
      focusState: $focusField,
      focusField: "location"
    )
    .rightImage(DesignSystemAsset.Icons.chevronDown24.swiftUIImage)
    .infoText( viewModel.showLocationError ?
               Constant.textFieldInfoText : "",
               color: .systemError
    )
    .disabled(true)
    .onTapGesture {
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
    .infoText( viewModel.showHeightError ?
               Constant.textFieldInfoText : "",
               color: .systemError
    )
  }
  
  private var weightTextField: some View {
    PCTextField(
      title: "몸무게",
      text: $viewModel.weight,
      focusState: $focusField,
      focusField: "weight"
    )
    .rightText("kg")
    .infoText( viewModel.showWeightError ?
               Constant.textFieldInfoText : "",
               color: .systemError
    )
  }
  
  private var jobTextField: some View {
    PCTextField(
      title: "직업",
      text: $viewModel.job,
      focusState: $focusField,
      focusField: "job"
    )
    .rightImage(DesignSystemAsset.Icons.chevronDown24.swiftUIImage)
    .infoText( viewModel.showJobError ?
               Constant.textFieldInfoText : "",
               color: .systemError
    )
    .disabled(true)
    .onTapGesture {
      viewModel.isJobSheetPresented = true
    }
  }
  
  private var smokingTextField: some View {
    VStack(alignment: .leading) {
      Text("흡연")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark3)
      HStack {
        SelectCard(isEditing:  viewModel.smokingStatus == "흡연", isSelected: viewModel.smokingStatus == "흡연", text: "흡연") {
          viewModel.smokingStatus = "흡연"
        }
        SelectCard(isEditing: viewModel.smokingStatus == "비흡연", isSelected: viewModel.smokingStatus == "비흡연", text: "비흡연") {
          viewModel.smokingStatus = "비흡연"
        }
      }
      Text( viewModel.showSmokingError ? Constant.textFieldInfoText : "")
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
        SelectCard(isEditing: viewModel.snsActivityLevel == "활동", isSelected: viewModel.snsActivityLevel == "활동", text: "활동") {
          viewModel.snsActivityLevel = "활동"
        }
        SelectCard(isEditing: viewModel.snsActivityLevel == "비활동", isSelected: viewModel.snsActivityLevel == "비활동", text: "비활동"){
          viewModel.snsActivityLevel = "비활동"
        }
      }
      Text(viewModel.showSNSError ?  Constant.textFieldInfoText : "")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.systemError)
    }
  }
  
  private var contactsTextField: some View {
    VStack(alignment: .leading) {
      Text("연락처")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark3)
      PCTextEditor(
        text: $viewModel.contacts[0],
        image: DesignSystemAsset.Icons.kakao20.swiftUIImage,
        showDeleteButton: false,
        action: { }
      )
      if viewModel.contacts.count > 1 {
        ForEach(viewModel.contacts.indices.dropFirst(), id: \.self) { index in
          PCTextEditor(
            text: $viewModel.contacts[index],
            image: DesignSystemAsset.Icons.kakao20.swiftUIImage,
            showDeleteButton: true,
            tapDeleteButton: { viewModel.contacts.remove(at: index) },
            action: {}
          )
        }
      }
    }
  }
  
  private var nextButton: some View {
    RoundedButton(
      type: .solid,
      buttonText: "다음",
      width: .maxWidth,
      action: { }
    )
  }
  
  private var jobBottomSheet: some View {
    PCBottomSheet(
      isPresented: $viewModel.isJobSheetPresented,
      height: 431,
      titleText: "직업 선택",
      buttonText: "저장하기",
      buttonAction: {
        viewModel.isJobSheetPresented = false
      }
    ) {
      ScrollView{
        VStack(alignment: .leading) {
          ForEach(viewModel.jobs, id: \.self) { job in
            cellItem(
              text: job,
              isSelected: true,
              action: {}
            )
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
  
  private var locationBottomSheet: some View {
    PCBottomSheet(
      isPresented: $viewModel.isLocationSheetPresented,
      height: 623,
      titleText: "활동지역 선택",
      buttonText: "저장하기",
      buttonAction: {
        viewModel.isLocationSheetPresented = false
      }
    ) {
      VStack {
        ScrollView{
          VStack(alignment: .leading) {
            ForEach(viewModel.locations, id: \.self) { location in
              cellItem(
                text: location,
                isSelected: true,
                action: {}
              )
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }
  
  private var snsBottomSheet: some View {
    PCBottomSheet(
      isPresented: $viewModel.isSNSSheetPresented,
      height: 479,
      titleText: "연락처 추가",
      buttonText: "추가하기",
      buttonAction: {
        viewModel.isSNSSheetPresented = false
      }
    ) {
      VStack {
        ScrollView{
          VStack(alignment: .leading) {
            ForEach(viewModel.snsContacts) { contacts in
              cellItem(
                image: contacts.icon,
                text: contacts.placeholder,
                isSelected: true,
                action: {}
              )
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
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
        }
        Text(text)
          .pretendard(.body_M_M)
          .foregroundStyle(Color.grayscaleBlack)
        Spacer()
        if  isSelected {
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

#Preview {
  CreateBasicInfoView()
}
