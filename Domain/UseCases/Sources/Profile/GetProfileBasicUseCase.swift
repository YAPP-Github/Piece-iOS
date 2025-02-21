//
//  GetProfileBasicUseCase.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Entities
import RepositoryInterfaces

public protocol GetProfileBasicUseCase {
  func execute() async throws -> ProfileModel
}

final class GetProfileUseCaseImpl: GetProfileBasicUseCase {
  private let repository: ProfileRepositoryInterface
  
  init(repository: ProfileRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async throws -> ProfileModel {
    try await repository.getProfileBasic()
  }
}
