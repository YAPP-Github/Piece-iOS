//
//  AvoidContactsGuideViewModel.swift
//  SignUp
//
//  Created by eunseou on 1/17/25.
//

import SwiftUI
import Observation

@Observable
final class AvoidContactsGuideViewModel {
  enum Action {
    case tapBlockContactButton
    case tapBackButton
    case tapDenyButton
  }
  
  func handleAction(_ action: Action) {
    switch action {
    default :
      return
    }
  }
}
