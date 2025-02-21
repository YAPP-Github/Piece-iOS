//
//  MatchResultViewFactory.swift
//  MatchResult
//
//  Created by summercat on 2/20/25.
//

import SwiftUI
import UseCases

public struct MatchResultViewFactory {
  public static func createMatchResultView(
    nickname: String,
    getMatchPhotoUseCase: GetMatchPhotoUseCase,
    getMatchContactsUseCase: GetMatchContactsUseCase
  ) -> some View {
    MatchResultView(
      nickname: nickname,
      getMatchPhotoUseCase: getMatchPhotoUseCase,
      getMatchContactsUseCase: getMatchContactsUseCase
    )
  }
}
