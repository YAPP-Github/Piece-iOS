//
//  LoginViewFactory.swift
//  Login
//
//  Created by eunseou on 2/7/25.
//

import SwiftUI
import UseCases

public struct LoginViewFactory {
  @ViewBuilder
  public static func createLoginView(
    socialLoginUseCase: SocialLoginUseCase
  ) -> some View {
    LoginView(socialLoginUseCase: socialLoginUseCase)
  }
}
