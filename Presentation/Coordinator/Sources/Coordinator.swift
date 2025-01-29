//
//  Coordinator.swift
//  Coordinator
//
//  Created by summercat on 1/30/25.
//

import MatchingDetail
import Router
import SwiftUI
import UseCases

public struct Coordinator {
  @ViewBuilder
  public static func view(for route: Route) -> some View {
    switch route {
    case .matchProfileBasic:
      MatchProfileBasicView(getMatchProfileBasicUseCase: UseCaseFactory.createGetMatchProfileBasicUseCase())
    case .matchValueTalk:
      EmptyView()
    }
  }
}
