//
//  SignUpViewFactory.swift
//  SignUp
//
//  Created by eunseou on 2/5/25.
//

import SwiftUI
import UseCases

public struct SignUpViewFactory {
  public static func createAvoidContactsGuideView(
    contactsPermissionUseCase: ContactsPermissionUseCase
  ) -> some View {
    AvoidContactsGuideView(contactsPermissionUseCase: contactsPermissionUseCase)
  }

  public static func createTermsAgreementView(
    fetchTermsUseCase: FetchTermsUseCase
  ) -> some View {
    TermsAgreementView(fetchTermsUseCase: fetchTermsUseCase)
  }
  
  public static func createProfileContainerView(
    checkNicknameUseCase: CheckNicknameUseCase,
    uploadProfileImageUseCase: UploadProfileImageUseCase,
    getValueTalksUseCase: GetValueTalksUseCase,
    getValuePicksUseCase: GetValuePicksUseCase,
    createProfileUseCase: CreateProfileUseCase
  ) -> some View {
    CreateProfileContainerView(
      checkNicknameUseCase: checkNicknameUseCase,
      uploadProfileImageUseCase: uploadProfileImageUseCase,
      getValueTalksUseCase: getValueTalksUseCase,
      getValuePicksUseCase: getValuePicksUseCase,
      createProfileUseCase: createProfileUseCase
    )
  }
}
