//
//  ProfileViewFactory.swift
//  Profile
//
//  Created by summercat on 1/30/25.
//

import SwiftUI
import UseCases

public struct ProfileViewFactory {
  @ViewBuilder
  public static func createProfileView(
    getProfileUseCase: GetProfileUseCase
  ) -> some View {
    ProfileView(getProfileUseCase: getProfileUseCase)
  }
}
