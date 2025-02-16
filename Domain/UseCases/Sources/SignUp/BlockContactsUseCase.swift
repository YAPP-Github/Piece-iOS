//
//  BlockContactsUseCase.swift
//  UseCases
//
//  Created by eunseou on 2/16/25.
//

import SwiftUI
import Entities
import RepositoryInterfaces
import Contacts

public protocol BlockContactsUseCase {
  func execute(phoneNumbers: BlockContactsModel) async throws -> VoidModel
}

final class BlockContactsUseCaseImpl: BlockContactsUseCase {
  private let repository: BlockContactsRepositoryInterface
  
  public init(
    repository: BlockContactsRepositoryInterface
  ) {
    self.repository = repository
  }
  
  func execute(phoneNumbers: BlockContactsModel) async throws -> VoidModel {
    return try await repository.postBlockContacts(phoneNumbers: phoneNumbers)
  }
}
