//
//  RequestContactsPermissionUseCase.swift
//  UseCases
//
//  Created by summercat on 3/26/25.
//

import Contacts

public protocol RequestContactsPermissionUseCase {
  func execute() async throws -> Bool
}

public final class RequestContactsPermissionUseCaseImpl: RequestContactsPermissionUseCase {
  private let contactStore: CNContactStore
  private let checkContactsPermissionUseCase: CheckContactsPermissionUseCase
  
  public init(
    contactStore: CNContactStore = CNContactStore(),
    checkContactsPermissionUseCase: CheckContactsPermissionUseCase
  ) {
    self.contactStore = contactStore
    self.checkContactsPermissionUseCase = checkContactsPermissionUseCase
  }
  
  public func execute() async throws -> Bool {
    let isAuthorized = try await checkContactsPermissionUseCase.execute()
    if isAuthorized {
      return true
    } else {
      return try await contactStore.requestAccess(for: .contacts)
    }
  }
}
