//
//  PatchLogoutUseCase.swift
//  UseCases
//
//  Created by eunseou on 3/9/25.
//

import Entities
import RepositoryInterfaces

public protocol PatchLogoutUseCase {
  func execute() async throws -> VoidModel
}

final class PatchLogoutUseCaseImpl: PatchLogoutUseCase {
  private let repository: SettingsRepositoryInterface
  
  init(repository: SettingsRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> VoidModel {
    try await repository.patchLogout()
  }
}
