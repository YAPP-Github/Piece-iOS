//
//  EditValueTalkViewFactory.swift
//  EditValueTalk
//
//  Created by summercat on 2/13/25.
//

import SwiftUI
import UseCases

public struct EditValueTalkViewFactory {
  public static func createEditValueTalkViewFactory(
    getProfileValueTalksUseCase: GetProfileValueTalksUseCase,
    updateProfileValueTalksUseCase: UpdateProfileValueTalksUseCase,
    connectSseUseCase: ConnectSseUseCase,
    disconnectSseUseCase: DisconnectSseUseCase
  ) -> some View {
    EditValueTalkView(
      getProfileValueTalksUseCase: getProfileValueTalksUseCase,
      updateProfileValueTalksUseCase: updateProfileValueTalksUseCase,
      connectSseUseCase: connectSseUseCase,
      disconnectSseUseCase: disconnectSseUseCase
    )
  }
}
