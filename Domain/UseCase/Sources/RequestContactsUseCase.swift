//
//  ContactsPermissionUseCase.swift
//  UseCase
//
//  Created by eunseou on 1/21/25.
//

import Foundation
import Contacts

public protocol RequestContactsUseCase {
  func execute() async throws -> Bool
}

public final class RequestContactsUseCaseImplementation: RequestContactsUseCase {
  private let contactStore: CNContactStore
  
  public init(contactStore: CNContactStore = CNContactStore()) {
    self.contactStore = contactStore
  }
  
  public func execute() async throws -> Bool {
    let status = CNContactStore.authorizationStatus(for: .contacts)
    
    switch status {
    case .authorized:
      return true
    case .notDetermined:
      return try await contactStore.requestAccess(for: .contacts)
    default:
      return false
    }
  }
}
