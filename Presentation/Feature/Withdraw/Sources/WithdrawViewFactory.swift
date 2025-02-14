//
//  WithdrawViewFactory.swift
//  Withdraw
//
//  Created by 김도형 on 2/13/25.
//

import SwiftUI

public struct WithdrawViewFactory {
    public static func createWithdrawView() -> some View {
        WithdrawView(viewModel: WithdrawViewModel())
    }
    
    public static func createWithdrawConfirm() -> some View {
        WithdrawConfirmView()
    }
}
