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

  public static func createAvoidContactsGuideView(
    contactsPermissionUseCase: ContactsPermissionUseCase
  ) -> some View {
    AvoidContactsGuideView(contactsPermissionUseCase: contactsPermissionUseCase)

  public static func createTermsAgreementView(
    fetchTermsUseCase: FetchTermsUseCase
  ) -> some View {
    TermsAgreementView(fetchTermsUseCase: fetchTermsUseCase)
  }
  public static func createProfileContainerView(
    createProfileUseCase: CreateProfileUseCase
  ) -> some View {
    CreateProfileContainerView(
      createProfileUseCase: createProfileUseCase
    )
  }
}
