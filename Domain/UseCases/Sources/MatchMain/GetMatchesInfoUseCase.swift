//
//  GetMatchesInfo.swift
//  UseCases
//
//  Created by eunseou on 2/15/25.
//

import SwiftUI
import Entities
import RepositoryInterfaces

public protocol GetMatchesInfoUseCase {
  func execute() async throws -> TermsListModel
}

final class GetMatchesInfoUseCaseImpl: GetMatchesInfoUseCase {
  private let repository: TermsRepositoryInterfaces
  
  init(repository: TermsRepositoryInterfaces) {
    self.repository = repository
  }
  
  func execute() async throws -> TermsListModel {
    return try await repository.fetchTermList()
  }
}
