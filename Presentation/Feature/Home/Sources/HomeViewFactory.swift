//
//  HomeViewFactory.swift
//  Home
//
//  Created by summercat on 1/30/25.
//

import SwiftUI

public struct HomeViewFactory {
  @ViewBuilder
  public static func createHomeView() -> some View {
    HomeView(viewModel: HomeViewModel())
  }
}
