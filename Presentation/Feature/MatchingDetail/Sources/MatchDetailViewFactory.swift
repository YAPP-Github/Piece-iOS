//
//  MatchDetailViewFactory.swift
//  MatchingDetail
//
//  Created by summercat on 1/30/25.
//

import SwiftUI
import UseCases

public struct MatchDetailViewFactory {
  @ViewBuilder
  public static func createMatchProfileBasicView(
    getMatchProfileBasicUseCase: GetMatchProfileBasicUseCase
  ) -> some View {
    MatchProfileBasicView(getMatchProfileBasicUseCase: getMatchProfileBasicUseCase)
  }
  
  @ViewBuilder
  public static func createMatchValueTalkView(
    getMatchValueTalkUseCase: GetMatchValueTalkUseCase,
    getMatchPhotoUseCase: GetMatchPhotoUseCase
  ) -> some View {
    ValueTalkView(
      getMatchValueTalkUseCase: getMatchValueTalkUseCase,
      getMatchPhotoUseCase: getMatchPhotoUseCase
    )
  }
  
  @ViewBuilder
  public static func createMatchValuePickView(
    getMatchValuePickUseCase: GetMatchValuePickUseCase
  ) -> some View {
    ValuePickView(getMatchValuePickUseCase: getMatchValuePickUseCase)
  }
}
