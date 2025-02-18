//
//  GetAppleOauthToken.swift
//  UseCases
//
//  Created by eunseou on 2/17/25.
//

import SwiftUI
import Entities
import RepositoryInterfaces

public protocol RevokeAppleOauthTokenUseCase {
  func execute() async throws -> VoidModel
}

final class RevokeAppleOauthTokenUseCaseImpl: RevokeAppleOauthTokenUseCase {
  private let repository: WithdrawRepositoryInterface
  
  public init(repository: WithdrawRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> VoidModel {
    return try await repository.withdrawWithApple()
  }
}
