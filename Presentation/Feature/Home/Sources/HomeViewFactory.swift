//
//  HomeViewFactory.swift
//  Home
//
//  Created by summercat on 1/30/25.
//

import SwiftUI
import UseCases

public struct HomeViewFactory {
  @ViewBuilder
  public static func createHomeView(getProfileUseCase: GetProfileUseCase) -> some View {
    HomeView(getProfileUseCase: getProfileUseCase)
  }
}
