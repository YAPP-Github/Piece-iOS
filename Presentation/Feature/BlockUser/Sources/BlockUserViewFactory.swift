//
//  BlockUserViewFactory.swift
//  BlockUser
//
//  Created by summercat on 2/12/25.
//

import SwiftUI
import UseCases

public struct BlockUserViewFactory {
  public static func createBlockUserView(
    matchId: Int,
    nickname: String,
    blockUserUseCase: BlockUserUseCase
  ) -> some View {
    BlockUserView(
      matchId: matchId,
      nickname: nickname,
      blockUserUseCase: blockUserUseCase
    )
  }
}
