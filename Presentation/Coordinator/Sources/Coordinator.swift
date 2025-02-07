//
//  Coordinator.swift
//  Coordinator
//
//  Created by summercat on 1/30/25.
//

import MatchingDetail
import Home
import SignUp
import Router
import SwiftUI
import UseCases

public struct Coordinator {
  @ViewBuilder
  public static func view(for route: Route) -> some View {
    switch route {
    case .home:
      HomeViewFactory.createHomeView()
    case .matchProfileBasic:
      let getMatchProfileBasicUseCase = UseCaseFactory.createGetMatchProfileBasicUseCase()
      MatchDetailViewFactory.createMatchProfileBasicView(getMatchProfileBasicUseCase: getMatchProfileBasicUseCase)
    case .matchValueTalk:
      let getMatchValueTalkUseCase = UseCaseFactory.createGetMatchValueTalkUseCase()
      MatchDetailViewFactory.createMatchValueTalkView(getMatchValueTalkUseCase: getMatchValueTalkUseCase)
    case .matchValuePick:
      let getMatchValuePickUseCase = UseCaseFactory.createGetMatchValuePickUseCase()
      MatchDetailViewFactory.createMatchValuePickView(getMatchValuePickUseCase: getMatchValuePickUseCase)
    case .AvoidContactsGuide:
      let contactsPermissionUseCase = UseCaseFactory.createContactsPermissionUseCase()
      SignUpViewFactory.createAvoidContactsGuideView(contactsPermissionUseCase: contactsPermissionUseCase)
    }
  }
}
