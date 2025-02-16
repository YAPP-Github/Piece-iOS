//
//  MatchMainViewFactory.swift
//  MatchingMain
//
//  Created by eunseou on 2/15/25.
//

import SwiftUI
import UseCases

public struct MatchMainViewFactory {
  @ViewBuilder
  public static func createMatchMainView(
    getMatchProfileBasicUseCase: GetMatchProfileBasicUseCase,
    acceptMatchUseCase: AcceptMatchUseCase
  ) -> some View {
    MatchingMainView(
      acceptMatchUseCase: acceptMatchUseCase,
      getMatchesProfileBasicUsecase: getMatchProfileBasicUseCase
    )
  }
}
