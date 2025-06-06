//
//  TermsWebView.swift
//  SignUp
//
//  Created by eunseou on 1/17/25.
//

import DesignSystem
import PCWebView
import SwiftUI
import Router
import Entities

struct TermsWebView: View {
  @State var viewModel: TermsWebViewModel
  @Environment(Router.self) private var router: Router
  
  init(term: TermModel) {
    _viewModel = .init(wrappedValue: .init(term: term))
  }
  
  var body: some View {
    ZStack {
      PCWebView(uri: viewModel.url)
        .padding(.bottom, 74)
      
      VStack {
        NavigationBar(
          title: viewModel.title,
          leftButtonTap: { router.pop() },
          backgroundColor: .white
        )
        
        Spacer()
        
        RoundedButton(
          type: .solid,
          buttonText: "동의하기",
          width: .maxWidth,
          action: {
            viewModel.handleAction(.tapAgreementButton)
            router.pop()
          }
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
      }
    }
    .toolbar(.hidden, for: .navigationBar)
  }
}

//#Preview {
//  TermsWebView(
//    viewModel: TermsWebViewModel(
//      term: TermModel(
//        id: 0,
//        title: "서비스 이용약관",
//        url: "https://brassy-client-c0a.notion.site/16a2f1c4b966800f923cd499d8e07a97",
//        required: true,
//        isChecked: false
//      )
//    )
//  )
//}
