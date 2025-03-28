//
//  SocialLoginUseCase.swift
//  UseCases
//
//  Created by eunseou on 2/7/25.
//

import Entities
import RepositoryInterfaces

public protocol SocialLoginUseCase {
  func execute(providerName: SocialLoginType, token: String) async throws -> SocialLoginResultModel
}

final class SocialLoginUseCaseImpl: SocialLoginUseCase {
  private let repository: LoginRepositoryInterface

  init(repository: LoginRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(providerName: SocialLoginType, token: String) async throws -> SocialLoginResultModel {
    return try await repository.socialLogin(providerName: providerName, token: token)
  }
}
