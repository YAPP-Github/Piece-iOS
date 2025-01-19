//
//  TermsAgreementView.swift
//  Login
//
//  Created by eunseou on 1/12/25.
//

import SwiftUI
import DesignSystem

struct TermsAgreementView: View {
  @State var viewModel: TermsAgreementViewModel
  
  var body: some View {
    ZStack {
      Color.grayscaleWhite.ignoresSafeArea()
      VStack(alignment: .center, spacing: 0) {
        title
        
        Spacer()
          .frame(height: 120)
        
        allTermsCheckBox
        
        termsList
        
        Spacer()
        
        nextButton
      }
      .padding(.horizontal, 20)
      .padding(.top, 20)
      .padding(.bottom, 10)
    }
    .navigationBarModifier {
      NavigationBar(
        title: "",
        leftButtonTap: { viewModel.handleAction(.tapBackButton) }
      )
    }
  }
  
  private var title: some View {
    VStack(alignment: .leading) {
      Text("Piece의")
      Text("이용약관")
        .foregroundStyle(Color.primaryDefault) +
      Text("을 확인해 주세요")
    }
    .pretendard(.heading_L_SB)
    .foregroundStyle(Color.grayscaleBlack)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var allTermsCheckBox: some View {
    CheckBox(
      label: "약관 전체동의",
      isChecked: viewModel.isAllChecked
    )
    .onTapGesture {
      viewModel.handleAction(.toggleAll)
    }
    .background(
      Rectangle()
        .foregroundStyle(Color.grayscaleLight3)
        .cornerRadius(8)
    )
    .padding(.bottom, 12)
  }
  
  private var termsList: some View {
    ForEach(viewModel.terms) { term in
      CheckBox(
        label: term.title,
        isChecked: term.isChecked,
        isRequrired: term.required,
        tapChevornButton: { viewModel.handleAction(.tapChevronButton) }
      )
      .onTapGesture {
        viewModel.handleAction(.toggleTerm(id: term.id))
      }
    }
  }
  
  private var nextButton: some View {
    RoundedButton(
      type: viewModel.nextButtonType,
      buttonText: "다음",
      action: { viewModel.handleAction(.tapNextButton) }
    )
  }
  
  private func CheckBox(
    label: String,
    isChecked: Bool,
    isRequrired: Bool? = nil,
    tapChevornButton: (()->Void)? = nil
  ) -> some View {
    HStack {
      DesignSystemAsset.Icons.checkCircle20.swiftUIImage
        .renderingMode(.template)
        .foregroundStyle(isChecked ? Color.primaryDefault : Color.grayscaleLight1)
      
      Text(isRequiredText(isRequrired) + label)
        .pretendard(.body_M_R)
        .foregroundStyle(Color.grayscaleBlack)
      
      Spacer()
      
      if let tapChevornButton {
        Button {
          tapChevornButton()
        } label: {
          DesignSystemAsset.Icons.chevronRight24.swiftUIImage
            .renderingMode(.template)
            .foregroundStyle(Color.grayscaleDark3)
        }
      }
    }
    .padding(.vertical, 14)
    .padding(.horizontal, 14)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private func isRequiredText(_ isRequired: Bool?) -> String {
    guard let isRequired = isRequired else { return "" }
    return isRequired ? "[필수] " : "[선택] "
  }
}

#Preview {
  TermsAgreementView(
    viewModel: TermsAgreementViewModel(
      terms: [
        TermModel(
          id: 0,
          title: "서비스 이용약관 동의",
          url: "",
          required: true,
          isChecked: false
        ),
        TermModel(
          id: 1,
          title: "개인정보처리 방침 동의",
          url: "",
          required: true,
          isChecked: false
        )
      ]
    )
  )
}
