//
//  CheckContactsPermissionUseCase.swift
//  UseCases
//
//  Created by summercat on 3/26/25.
//

import Contacts

public protocol CheckContactsPermissionUseCase {
  func execute() async throws -> Bool
}

final class CheckContactsPermissionUseCaseImpl: CheckContactsPermissionUseCase {
  private let contactStore: CNContactStore
  
  public init(contactStore: CNContactStore = CNContactStore()) {
    self.contactStore = contactStore
  }
  
  public func execute() async throws -> Bool {
    let status = CNContactStore.authorizationStatus(for: .contacts)
    
    switch status {
    case .notDetermined:
      return false
    case .denied, .restricted:
      return false
    case .authorized, .limited:
      return true
    @unknown default:
      return false
    }
  }
}
