//
//  SocialLoginUseCase.swift
//  UseCases
//
//  Created by eunseou on 2/7/25.
//

import SwiftUI
import Entities
import DTO
import RepositoryInterfaces

public protocol SocialLoginUseCase {
  func execute(providerName: SocialLoginType, token: String) async throws -> SocialLoginModel
}

final class SocialLoginUseCaseImpl: SocialLoginUseCase {
  private let repository: LoginRepositoryInterfaces

  init(repository: LoginRepositoryInterfaces) {
    self.repository = repository
  }
  
  func execute(providerName: SocialLoginType, token: String) async throws -> SocialLoginModel {
    return try await repository.socialLogin(providerName: providerName, token: token)
  }
}
