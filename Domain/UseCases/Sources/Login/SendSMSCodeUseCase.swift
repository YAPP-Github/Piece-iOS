//
//  SendSMSCodeUseCase.swift
//  UseCases
//
//  Created by eunseou on 2/15/25.
//

import SwiftUI
import Entities
import RepositoryInterfaces

public protocol SendSMSCodeUseCase {
  func execute(phoneNumber: String) async throws -> Bool
}

final class SendSMSCodeUseCaseImpl: SendSMSCodeUseCase {
  private let repository: LoginRepositoryInterfaces

  init(repository: LoginRepositoryInterfaces) {
    self.repository = repository
  }
  
  func execute(phoneNumber: String) async throws -> Bool {
    return try await repository.sendSMSCode(phoneNumber: phoneNumber)
  }
}
