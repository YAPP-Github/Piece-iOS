//
//  SignUpViewFactory.swift
//  SignUp
//
//  Created by eunseou on 2/5/25.
//

import SwiftUI
import UseCases

public struct SignUpViewFactory {
  @ViewBuilder
  public static func createTermsAgreementView(
    fetchTermsUseCase: FetchTermsUseCase
  ) -> some View {
    TermsAgreementView(fetchTermsUseCase: fetchTermsUseCase)
  }
}
