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
    case tapBackButton
    case tapDenyButton
    case showShettingAlert
    case cancelAlert
  }
  
  var showToast = false
  var isPresentedAlert: Bool = false
  private var dismissAction: (() -> Void)?
  private var navigationAction: (() -> Void)?
  private let contactsPermissionUseCase: ContactsPermissionUseCase
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapAccepetButton:
      Task {
        await handleAcceptButtonTap()
      }
    case .tapBackButton:
      dismissAction?()
    case .tapDenyButton:
      navigationAction?()
    case .showShettingAlert:
      openSettings()
    case .cancelAlert:
      isPresentedAlert = false
    }
  }
  
  init(
    showToast: Bool = false,
    contactsPermissionUseCase: ContactsPermissionUseCase
  ) {
    self.showToast = showToast
    self.contactsPermissionUseCase = contactsPermissionUseCase
  }
  
  func setDismissAction(_ dismiss: @escaping () -> Void) {
    self.dismissAction = dismiss
  }
  
  @MainActor
  private func handleAcceptButtonTap() async {
    do {
      let isAuthorized = try await contactsPermissionUseCase.execute()
      
      if isAuthorized {
        await isToastVisible()
        navigationAction?()
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
    try? await Task.sleep(for: .seconds(3))
    showToast = false
  }
  
  private func openSettings() {
    guard let url = URL(string: UIApplication.openSettingsURLString),
          UIApplication.shared.canOpenURL(url) else { return }
    
    UIApplication.shared.open(url)
  }
}
