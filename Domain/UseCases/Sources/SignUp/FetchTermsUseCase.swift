//
//  TermsUseCase.swift
//  UseCases
//
//  Created by eunseou on 2/5/25.
//

import Foundation
import Entities
import Repository

public protocol FetchTermsUseCase {
  func execute() async throws -> TermsListModel
}

final class FetchTermsUseCaseImpl: FetchTermsUseCase {
  
  private let repository: TermsRepository
  
  init(repository: TermsRepository) {
    self.repository = repository
  }
  
  func execute() async throws -> TermsListModel {
    return try await repository.fetchTermList()
  }
}
