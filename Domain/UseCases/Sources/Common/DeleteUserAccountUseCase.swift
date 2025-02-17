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
  func execute(reason: String) async throws -> VoidModel
}

final class DeleteUserAccountUseCaseImpl: DeleteUserAccountUseCase {
  private let repository: WithdrawRepositoryInterface
  
  public init(repository: WithdrawRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(reason: String) async throws -> VoidModel {
    return try await repository.deleteUserAccount(reason: reason)
  }
}
