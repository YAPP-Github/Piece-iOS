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
    contactsPermissionUseCase: ContactsPermissionUseCase,
    fetchContactsUseCase: FetchContactsUseCase,
    blockContactsUseCase: BlockContactsUseCase
  ) -> some View {
    AvoidContactsGuideView(
      contactsPermissionUseCase: contactsPermissionUseCase,
      fetchContactsUseCase: fetchContactsUseCase,
      blockContactsUseCase: blockContactsUseCase
    )
  }

  public static func createTermsAgreementView(
    fetchTermsUseCase: FetchTermsUseCase
  ) -> some View {
    TermsAgreementView(fetchTermsUseCase: fetchTermsUseCase)
  }
  
  public static func createTermsWebView(title: String, url: String) -> some View {
    TermsWebView(title: title, url: url)
  }
  
  public static func createPermissionRequestView(
    cameraPermissionUseCase: CameraPermissionUseCase,
    photoPermissionUseCase: PhotoPermissionUseCase,
    contactsPermissionUseCase: ContactsPermissionUseCase,
    notificationPermissionUseCase: NotificationPermissionUseCase
  ) -> some View {
    PermissionRequestView(
      cameraPermissionUseCase: cameraPermissionUseCase,
      photoPermissionUseCase: photoPermissionUseCase,
      contactsPermissionUseCase: contactsPermissionUseCase,
      notificationPermissionUseCase: notificationPermissionUseCase
    )
  }
  
  public static func createCompleteSignUpView() -> some View {
    CompleteSignUpView()
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
  
  public static func createWaitingAISummaryView(
    getAISummaryUseCase: GetAISummaryUseCase,
    finishAISummaryUseCase: FinishAISummaryUseCase
  ) -> some View {
    WaitingAISummaryView(
      getAISummaryUseCase: getAISummaryUseCase,
      finishAISummaryUseCase: finishAISummaryUseCase
    )
  }
  
  public static func createCompleteCreateProfileView() -> some View {
    CompleteCreateProfileView()
  }
}
