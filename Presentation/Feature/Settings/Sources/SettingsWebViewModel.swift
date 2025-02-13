//
//  SettingsWebViewModel.swift
//  Settings
//
//  Created by summercat on 2/12/25.
//

import Entities
import SwiftUI
import Observation

@Observable
final class SettingsWebViewModel {
  enum Action {
    case tapBackButton
  }
  
  let title: String
  let uri: String
  private var dismissAction: (() -> Void)?
  
  init(title: String, uri: String) {
    self.title = title
    self.uri = uri
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapBackButton:
      dismissAction?()
    }
  }
  
  func setDismissAction(_ dismiss: @escaping () -> Void) {
    self.dismissAction = dismiss
  }
}
