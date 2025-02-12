//
//  EditValuePickViewFactory.swift
//  EditValuePick
//
//  Created by summercat on 2/12/25.
//

import SwiftUI
import UseCases

public struct EditValuePickViewFactory {
  public static func createEditValuePickViewFactory(
    getMatchValuePicksUseCase: GetMatchValuePicksUseCase,
    updateMatchValuePicksUseCase: UpdateMatchValuePicksUseCase
  ) -> some View {
    EditValuePickView(
      getMatchValuePicksUseCase: getMatchValuePicksUseCase,
      updateMatchValuePicksUseCase: updateMatchValuePicksUseCase
    )
  }
}
