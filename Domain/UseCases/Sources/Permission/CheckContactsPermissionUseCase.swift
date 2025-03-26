//
//  CheckContactsPermissionUseCase.swift
//  UseCases
//
//  Created by summercat on 3/26/25.
//

import Contacts

public protocol CheckContactsPermissionUseCase {
  func execute() -> CNAuthorizationStatus
}

final class CheckContactsPermissionUseCaseImpl: CheckContactsPermissionUseCase {
  private let contactStore: CNContactStore
  
  public init(contactStore: CNContactStore = CNContactStore()) {
    self.contactStore = contactStore
  }
  
  public func execute() -> CNAuthorizationStatus {
    return CNContactStore.authorizationStatus(for: .contacts)
  }
}
