//
//  TermsWebView.swift
//  SignUp
//
//  Created by eunseou on 1/17/25.
//

import SwiftUI
import DesignSystem

struct TermsWebView: View {
  @State var viewModel: TermsWebViewModel
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    ZStack {
      WebView(urlString: viewModel.term.url)
        .padding(.bottom, 74)
      
      VStack {
        Spacer()
        
        RoundedButton(
          type: .solid,
          buttonText: "동의하기",
          action: { viewModel.handleAction(.tapAgreementButton) }
        )
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 10)
    }
    .navigationBarModifier {
      NavigationBar(
        title: viewModel.term.title,
        leftButtonTap: { viewModel.handleAction(.tapBackButton) }
      )
    }
    .onAppear {
      viewModel.setDismissAction { dismiss() }
    }
  }
}

#Preview {
  TermsWebView(
    viewModel: TermsWebViewModel(
      term: TermModel(
        id: 0,
        title: "서비스 이용약관",
        url: "https://brassy-client-c0a.notion.site/16a2f1c4b966800f923cd499d8e07a97",
        required: true,
        isChecked: false
      )
    )
  )
}
