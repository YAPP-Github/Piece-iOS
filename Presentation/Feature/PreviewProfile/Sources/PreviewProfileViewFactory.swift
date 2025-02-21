//
//  PreviewProfileViewFactory.swift
//  PreviewProfile
//
//  Created by summercat on 1/30/25.
//

import SwiftUI
import UseCases

public struct PreviewProfileViewFactory {
  @ViewBuilder
  public static func createMatchProfileBasicView(getProfileBasicUseCase: GetProfileBasicUseCase) -> some View {
    PreviewProfileBasicView(getProfileBasicUseCase: getProfileBasicUseCase)
  }
  
  @ViewBuilder
  public static func createMatchValueTalkView(
    nickname: String,
    description: String,
    imageUri: String,
    getProfileValueTalksUseCase: GetProfileValueTalksUseCase
  ) -> some View {
    ValueTalkView(
      nickname: nickname,
      description: description,
      imageUri: imageUri,
      getProfileValueTalksUseCase: getProfileValueTalksUseCase
    )
  }
  
  @ViewBuilder
  public static func createMatchValuePickView(
    nickname: String,
    description: String,
    imageUri: String,
    getProfileValuePicksUseCase: GetProfileValuePicksUseCase
  ) -> some View {
    ValuePickView(
      nickname: nickname,
      description: description,
      imageUri: imageUri,
      getProfileValuePicksUseCase: getProfileValuePicksUseCase
    )
  }
}
