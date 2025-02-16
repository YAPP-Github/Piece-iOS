//
//  UpdateProfileValueTalkSummaryUseCase.swift
//  UseCases
//
//  Created by summercat on 2/16/25.
//

import Entities
import RepositoryInterfaces

public protocol UpdateProfileValueTalkSummaryUseCase {
  func execute(profileTalkId: Int, summary: String) async throws -> VoidModel
}

final class UpdateProfileValueTalkSummaryUseCaseImpl: UpdateProfileValueTalkSummaryUseCase {
  private let repository: ProfileRepositoryInterface
  
  init(repository: ProfileRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(profileTalkId: Int, summary: String) async throws -> VoidModel {
    try await repository.updateProfileValueTalkSummary(profileTalkId: profileTalkId, summary: summary)
  }
}
