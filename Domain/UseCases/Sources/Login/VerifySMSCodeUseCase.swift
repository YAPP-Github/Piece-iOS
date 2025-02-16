//
//  VerifySMSCodeUseCase.swift
//  UseCases
//
//  Created by eunseou on 2/15/25.
//

import SwiftUI
import Entities
import RepositoryInterfaces

public protocol VerifySMSCodeUseCase {
  func execute(phoneNumber: String, code: String) async throws -> SocialLoginResultModel
}

final class VerifySMSCodeUseCaseImpl: VerifySMSCodeUseCase {
  private let repository: LoginRepositoryInterfaces

  init(repository: LoginRepositoryInterfaces) {
    self.repository = repository
  }
  
  func execute(phoneNumber: String, code: String) async throws -> SocialLoginResultModel {
    return try await repository.verifySMSCode(phoneNumber: phoneNumber, code: code)
  }
}
