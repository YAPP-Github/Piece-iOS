//
//  SignUpViewFactory.swift
//  SignUp
//
//  Created by eunseou on 2/5/25.
//

import Entities
import SwiftUI
import UseCases

public struct SignUpViewFactory {
  public static func createAvoidContactsGuideView(
    requestContactsPermissionUseCase: RequestContactsPermissionUseCase,
    fetchContactsUseCase: FetchContactsUseCase,
    blockContactsUseCase: BlockContactsUseCase
  ) -> some View {
    AvoidContactsGuideView(
      requestContactsPermissionUseCase: requestContactsPermissionUseCase,
      fetchContactsUseCase: fetchContactsUseCase,
      blockContactsUseCase: blockContactsUseCase
    )
  }

  public static func createTermsAgreementView(
    fetchTermsUseCase: FetchTermsUseCase
  ) -> some View {
    TermsAgreementView(fetchTermsUseCase: fetchTermsUseCase)
  }
  
  public static func createTermsWebView(term: TermModel) -> some View {
    TermsWebView(term: term)
  }
  
  public static func createPermissionRequestView(
    cameraPermissionUseCase: CameraPermissionUseCase,
    photoPermissionUseCase: PhotoPermissionUseCase,
    requestContactsPermissionUseCase: RequestContactsPermissionUseCase,
    requestNotificationPermissionUseCase: RequestNotificationPermissionUseCase
  ) -> some View {
    PermissionRequestView(
      cameraPermissionUseCase: cameraPermissionUseCase,
      photoPermissionUseCase: photoPermissionUseCase,
      requestContactsPermissionUseCase: requestContactsPermissionUseCase,
      requestNotificationPermissionUseCase: requestNotificationPermissionUseCase
    )
  }
  
  public static func createCompleteSignUpView() -> some View {
    CompleteSignUpView()
  }
  
  public static func createProfileContainerView(
    checkNicknameUseCase: CheckNicknameUseCase,
    uploadProfileImageUseCase: UploadProfileImageUseCase,
    getValueTalksUseCase: GetValueTalksUseCase,
    getValuePicksUseCase: GetValuePicksUseCase
  ) -> some View {
    CreateProfileContainerView(
      checkNicknameUseCase: checkNicknameUseCase,
      uploadProfileImageUseCase: uploadProfileImageUseCase,
      getValueTalksUseCase: getValueTalksUseCase,
      getValuePicksUseCase: getValuePicksUseCase
    )
  }
  
  public static func createWaitingAISummaryView(
    profile: ProfileModel,
    createProfileUseCase: CreateProfileUseCase
  ) -> some View {
    WaitingAISummaryView(
      profile: profile,
      createProfileUseCase: createProfileUseCase
    )
  }
  
  public static func createCompleteCreateProfileView() -> some View {
    CompleteCreateProfileView()
  }
}
