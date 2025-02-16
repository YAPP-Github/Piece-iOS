//
//  SSERepositoryInterface.swift
//  RepositoryInterfaces
//
//  Created by summercat on 2/16/25.
//

import Entities

public protocol SSERepositoryInterface {
  func connectSse() -> AsyncThrowingStream<AISummaryModel, Error>
  func disconnectSse() async throws -> VoidModel
}
