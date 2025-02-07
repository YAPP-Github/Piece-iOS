//
//  SignUpFactory.swift
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
  }
}
