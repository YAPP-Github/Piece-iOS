//
//  AvoidContactsGuideViewModel.swift
//  SignUp
//
//  Created by eunseou on 1/17/25.
//

import SwiftUI
import Observation
import UseCases

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
  
  init(contactsPermissionUseCase: ContactsPermissionUseCase) {
    self.contactsPermissionUseCase = contactsPermissionUseCase
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
