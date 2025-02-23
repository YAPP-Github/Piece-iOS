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
    getServerStatusUseCase: GetServerStatusUseCase,
    socialLoginUseCase: SocialLoginUseCase,
    appleAuthServiceUseCase: AppleAuthServiceUseCase
  ) -> some View {
    SplashView(
      getServerStatusUseCase: getServerStatusUseCase,
      socialLoginUseCase: socialLoginUseCase,
      appleAuthServiceUseCase: appleAuthServiceUseCase
    )
  }
}
