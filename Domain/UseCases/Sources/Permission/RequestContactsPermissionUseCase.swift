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
    let authorizationStatus = checkContactsPermissionUseCase.execute()
    switch authorizationStatus {
    case .notDetermined:
      return try await contactStore.requestAccess(for: .contacts)
    case .restricted:
      return try await contactStore.requestAccess(for: .contacts)
    case .denied:
      return try await contactStore.requestAccess(for: .contacts)
    case .authorized:
      return true
    case .limited:
      return true
    @unknown default:
      return try await contactStore.requestAccess(for: .contacts)
    }
  }
}
