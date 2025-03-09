//
//  WithdrawViewFactory.swift
//  Withdraw
//
//  Created by 김도형 on 2/13/25.
//

import SwiftUI
import UseCases

public struct WithdrawViewFactory {
    public static func createWithdrawView() -> some View {
        WithdrawView(viewModel: WithdrawViewModel())
    }
    
  public static func createWithdrawConfirmView(
    deleteUserAccountUseCase: DeleteUserAccountUseCase,
    appleAuthServiceUseCase: AppleAuthServiceUseCase
  ) -> some View {
      WithdrawConfirmView(
        deleteUserAccountUseCase: deleteUserAccountUseCase,
        appleAuthServiceUseCase: appleAuthServiceUseCase
      )
    }
}
