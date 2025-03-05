//
//  TabBarViewModel.swift
//  Home
//
//  Created by summercat on 3/6/25.
//

import LocalStorage
import Observation

@Observable
class TabBarViewModel {
  var selectedTab: Tab = .home
  var isProfileTabDisabled: Bool
  
  init() {
    let userRole = PCUserDefaultsService.shared.getUserRole()
    if userRole == .USER {
      isProfileTabDisabled = false
    } else {
      isProfileTabDisabled = true
    }
  }
  
  enum Tab {
    case profile
    case home
    case settings
  }
}
