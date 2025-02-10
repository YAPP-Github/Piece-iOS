//
//  CreateProfileContainerView.swift
//  SignUp
//
//  Created by summercat on 2/8/25.
//

import DesignSystem
import Router
import SwiftUI
import UseCases

struct CreateProfileContainerView: View {
  @Bindable var viewModel: CreateProfileContainerViewModel
  @Environment(Router.self) private var router: Router
  
  init(
  ) {
    _viewModel = .init(
      .init(
      )
    )
  }
  
  var body: some View {
    NavigationStack(path: $viewModel.presentedStep) {
    }
  }
}
