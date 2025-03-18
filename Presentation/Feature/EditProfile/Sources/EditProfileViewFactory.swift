//
//  ProfileEditViewFactory.swift
//  ProfileEdit
//
//  Created by eunseou on 3/17/25.
//

import Entities
import SwiftUI
import UseCases

public struct EditProfileViewFactory {
  public static func createEditProfileView(
    updateProfileBasicUseCase: UpdateProfileBasicUseCase,
    getProfileBasicUseCase: GetProfileBasicUseCase,
    checkNicknameUseCase: CheckNicknameUseCase,
    uploadProfileImageUseCase: UploadProfileImageUseCase
  ) -> some View {
    EditProfileView(
      updateProfileBasicUseCase: updateProfileBasicUseCase,
      getProfileBasicUseCase: getProfileBasicUseCase,
      checkNicknameUseCase: checkNicknameUseCase,
      uploadProfileImageUseCase: uploadProfileImageUseCase
    )
  }
}
