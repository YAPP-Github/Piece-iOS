//
//  BlockContactsUseCase.swift
//  UseCases
//
//  Created by eunseou on 2/16/25.
//

import Entities
import Foundation
import RepositoryInterfaces
import Contacts

public protocol BlockContactsUseCase {
  func execute(phoneNumbers: [String]) async throws -> VoidModel
}

final class BlockContactsUseCaseImpl: BlockContactsUseCase {
  private let repository: BlockContactsRepositoryInterface
  
  public init(
    repository: BlockContactsRepositoryInterface
  ) {
    self.repository = repository
  }
  
  func execute(phoneNumbers: [String]) async throws -> VoidModel {
    let encodedContacts = phoneNumbers.compactMap { $0.data(using: .utf8)?.base64EncodedString() }
    let blockContactsModel = BlockContactsModel(phoneNumbers: encodedContacts)
    return try await repository.postBlockContacts(phoneNumbers: blockContactsModel)
  }
}
