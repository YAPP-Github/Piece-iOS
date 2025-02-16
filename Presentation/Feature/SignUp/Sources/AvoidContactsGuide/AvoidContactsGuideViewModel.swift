//
//  AvoidContactsGuideViewModel.swift
//  SignUp
//
//  Created by eunseou on 1/17/25.
//

import SwiftUI
import Observation
import UseCases
import Entities

@Observable
final class AvoidContactsGuideViewModel {
  enum Action {
    case tapAccepetButton
    case showShettingAlert
    case cancelAlert
  }
  
  private(set) var showToast = false
  private(set) var moveToCompleteSignUp: Bool = false
  var isPresentedAlert: Bool = false
  private let contactsPermissionUseCase: ContactsPermissionUseCase
  private let fetchContactsUseCase: FetchContactsUseCase
  private let blockContactsUseCase: BlockContactsUseCase
  
  init(
    contactsPermissionUseCase: ContactsPermissionUseCase,
    fetchContactsUseCase: FetchContactsUseCase,
    blockContactsUseCase: BlockContactsUseCase
  ) {
    self.contactsPermissionUseCase = contactsPermissionUseCase
    self.fetchContactsUseCase = fetchContactsUseCase
    self.blockContactsUseCase = blockContactsUseCase
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapAccepetButton:
      Task {
        await handleAcceptButtonTap()
      }
    case .showShettingAlert:
      openSettings()
    case .cancelAlert:
      isPresentedAlert = false
    }
  }
  
  @MainActor
  private func handleAcceptButtonTap() async {
    do {
      let isAuthorized = try await contactsPermissionUseCase.execute()
      
      if isAuthorized {
        await isToastVisible()
        let userContacts = try await fetchContactsUseCase.execute()
        let encodedContacts = userContacts.compactMap { $0.data(using: .utf8)?.base64EncodedString() }
        
        let phoneNumbers: BlockContactsModel = BlockContactsModel(phoneNumbers: encodedContacts)
        _ = try await blockContactsUseCase.execute(phoneNumbers: phoneNumbers)
        
      } else {
        isPresentedAlert = true
      }
    } catch {
      print("\(error.localizedDescription)")
    }
  }
  
  @MainActor
  private func isToastVisible() async {
    showToast = true
    try? await Task.sleep(for: .seconds(2))
    showToast = false
    moveToCompleteSignUp = true
  }
  
  private func openSettings() {
    guard let url = URL(string: UIApplication.openSettingsURLString),
          UIApplication.shared.canOpenURL(url) else { return }
    
    UIApplication.shared.open(url)
  }
}
