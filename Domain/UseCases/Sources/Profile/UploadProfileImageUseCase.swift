//
//  UploadProfileImageUseCase.swift
//  UseCases
//
//  Created by eunseou on 2/12/25.
//

import SwiftUI
import RepositoryInterfaces

public protocol UploadProfileImageUseCase {
  func execute(image: Data) async throws -> URL
}

final class UploadProfileImageUseCaseImpl: UploadProfileImageUseCase {
  private let repository: ProfileRepositoryInterface
  
  init(repository: ProfileRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(image: Data) async throws -> URL {
    try await repository.uploadProfileImage(image)
  }
}
