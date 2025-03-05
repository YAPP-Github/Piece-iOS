//
//  SplashViewFactory.swift
//  Splash
//
//  Created by summercat on 2/15/25.
//

import SwiftUI
import UseCases

public struct SplashViewFactory {
  public static func createSplashView(
    getUserInfoUseCase: GetUserInfoUseCase
  ) -> some View {
    SplashView(getUserInfoUseCase: getUserInfoUseCase)
  }
}
