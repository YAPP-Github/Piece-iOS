//
//  GetAISummaryUseCase.swift
//  UseCases
//
//  Created by summercat on 2/16/25.
//

import Entities
import RepositoryInterfaces

public protocol GetAISummaryUseCase {
  func execute() -> AsyncThrowingStream<AISummaryModel, Error>
}

final class GetAISummaryUseCaseImpl: GetAISummaryUseCase {
  private let repository: SSERepositoryInterface
  
  init(repository: SSERepositoryInterface) {
    self.repository = repository
  }
  
  func execute() -> AsyncThrowingStream<AISummaryModel, Error> {
    repository.connectSse()
  }
}
