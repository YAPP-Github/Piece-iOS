//
//  Coordinator.swift
//  Coordinator
//
//  Created by summercat on 1/30/25.
//

import MatchingDetail
import Home
import Router
import SwiftUI
import UseCases

public struct Coordinator {
  public init() { }
  
  private let getMatchProfileBasicUseCase = UseCaseFactory.createGetMatchProfileBasicUseCase()
  private let getMatchValueTalkUseCase = UseCaseFactory.createGetMatchValueTalkUseCase()
  private let getMatchValuePickUseCase = UseCaseFactory.createGetMatchValuePickUseCase()
  private let getMatchPhotoUseCase = UseCaseFactory.createGetMatchPhotoUseCase()
  
  @ViewBuilder
  public func view(for route: Route) -> some View {
    switch route {
    case .home:
      HomeViewFactory.createHomeView()
    case .matchProfileBasic:
      MatchDetailViewFactory.createMatchProfileBasicView(
        getMatchProfileBasicUseCase: getMatchProfileBasicUseCase,
        getMatchPhotoUseCase: getMatchPhotoUseCase
      )
    case .matchValueTalk:
      MatchDetailViewFactory.createMatchValueTalkView(
        getMatchValueTalkUseCase: getMatchValueTalkUseCase,
        getMatchPhotoUseCase: getMatchPhotoUseCase
      )
    case .matchValuePick:
      MatchDetailViewFactory.createMatchValuePickView(
        getMatchValuePickUseCase: getMatchValuePickUseCase,
        getMatchPhotoUseCase: getMatchPhotoUseCase
      )
    }
  }
}
