//
//  deleteUserAccountUseCase.swift
//  UseCases
//
//  Created by eunseou on 2/17/25.
//

import SwiftUI
import Entities
import RepositoryInterfaces

public protocol DeleteUserAccountUseCase {
  func execute(providerName: String, oauthCredential: String, reason: String) async throws -> VoidModel
}

final class DeleteUserAccountUseCaseImpl: DeleteUserAccountUseCase {
  private let repository: WithdrawRepositoryInterface
  
  public init(repository: WithdrawRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(providerName: String, oauthCredential: String, reason: String) async throws -> VoidModel {
    return try await repository.deleteUserAccount(providerName: providerName, oauthCredential: oauthCredential, reason: reason)
  }
}
