//
//  RegisterFcmTokenUseCase.swift
//  UseCases
//
//  Created by summercat on 3/6/25.
//

import Entities
import RepositoryInterfaces

public protocol RegisterFcmTokenUseCase {
  func execute(token: String) async throws -> VoidModel
}

final class RegisterFcmTokenUseCaseImpl: RegisterFcmTokenUseCase {
  private let repository: LoginRepositoryInterface
  
  init(repository: LoginRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(token: String) async throws -> VoidModel {
    return try await repository.registerFcmToken(token: token)
  }
}
