//
// ProfileViewModel.swift
// Profile
//
// Created by summercat on 2025/01/30.
//

import Foundation
import PCFoundationExtension
import UseCases

@Observable
final class ProfileViewModel {
  enum Action { }
  
  init(getProfileUseCase: GetProfileBasicUseCase) {
    self.getProfileUseCase = getProfileUseCase
    
    Task {
      await fetchUserProfile()
    }
  }
  
  private let getProfileUseCase: GetProfileBasicUseCase
  private(set) var isLoading = true
  private(set) var error: Error?
  private(set) var userProfile: UserProfile?
  
  private func fetchUserProfile() async {
    do {
      let entity = try await getProfileUseCase.execute()
      userProfile = UserProfile(
        nickname: entity.nickname,
        description: entity.description,
        age: entity.age,
        birthdate: entity.birthdate.extractYear(),
        height: entity.height,
        weight: entity.weight,
        job: entity.job,
        location: entity.location,
        smokingStatus: entity.smokingStatus,
        imageUri: entity.imageUri
      )
      error = nil
    } catch {
      self.error = error
    }
    isLoading = false
  }
}
