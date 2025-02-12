//
//  CheckNicknameUseCase.swift
//  UseCases
//
//  Created by eunseou on 2/12/25.
//

import Entities
import RepositoryInterfaces

public protocol CheckNicknameUseCase {
  func execute(nickname: String) async throws -> Bool
}

final class CheckNicknameUseCaseImpl: CheckNicknameUseCase {
  private let repository: CheckNinknameRepositoryInterface
  
  init(repository: CheckNinknameRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(nickname: String) async throws -> Bool {
    return try await repository.checkNickname(nickname: nickname)
  }
}
