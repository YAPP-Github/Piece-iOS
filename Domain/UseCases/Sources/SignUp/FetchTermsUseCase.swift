//
//  TermsUseCase.swift
//  UseCases
//
//  Created by eunseou on 2/5/25.
//

import Foundation
import Entities
import RepositoryInterfaces

public protocol FetchTermsUseCase {
  func execute() async throws -> TermsListModel
}

final class FetchTermsUseCaseImpl: FetchTermsUseCase {
  
  private let repository: TermsRepositoryInterfaces
  
  init(repository: TermsRepositoryInterfaces) {
    self.repository = repository
  }
  
  func execute() async throws -> TermsListModel {
    return try await repository.fetchTermList()
  }
}
