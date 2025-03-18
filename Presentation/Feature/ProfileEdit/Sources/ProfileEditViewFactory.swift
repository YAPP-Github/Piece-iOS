//
//  ProfileEditViewFactory.swift
//  ProfileEdit
//
//  Created by eunseou on 3/17/25.
//

import Entities
import SwiftUI
import UseCases

public struct ProfileEditViewFactory {
  public static func createProfileEditView(
    updateProfileBasicUseCase: UpdateProfileBasicUseCase,
    getProfileBasicUseCase: GetProfileBasicUseCase,
    checkNicknameUseCase: CheckNicknameUseCase,
    uploadProfileImageUseCase: UploadProfileImageUseCase
  ) -> some View {
    ProfileEditView(
      updateProfileBasicUseCase: updateProfileBasicUseCase,
      getProfileBasicUseCase: getProfileBasicUseCase,
      checkNicknameUseCase: checkNicknameUseCase,
      uploadProfileImageUseCase: uploadProfileImageUseCase
    )
  }
}
