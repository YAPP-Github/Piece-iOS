//
//  ContactsPermissionUseCase.swift
//  UseCase
//
//  Created by eunseou on 1/21/25.
//

import Foundation
import Contacts

public protocol ContactsPermissionUseCase {
  func execute() async throws -> Bool
}

public final class ContactsPermissionUseCaseImpl: ContactsPermissionUseCase {
  private let contactStore: CNContactStore
  
  public init(contactStore: CNContactStore = CNContactStore()) {
    self.contactStore = contactStore
  }
  
  public func execute() async throws -> Bool {
    let status = CNContactStore.authorizationStatus(for: .contacts)
    
    switch status {
    case .notDetermined:
      return try await contactStore.requestAccess(for: .contacts)
    case .denied, .restricted:
      return false
    case .authorized, .limited:
      return true
    @unknown default:
      return false
    }
  }
}
