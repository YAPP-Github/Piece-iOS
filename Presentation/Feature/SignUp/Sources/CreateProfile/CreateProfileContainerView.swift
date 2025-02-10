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
    createProfileUseCase: CreateProfileUseCase
  ) {
    _viewModel = .init(
      .init(
        createProfileUseCase: createProfileUseCase
      )
    )
  }
  
  var body: some View {
    NavigationStack(path: $viewModel.presentedStep) {
    }
  }
}
