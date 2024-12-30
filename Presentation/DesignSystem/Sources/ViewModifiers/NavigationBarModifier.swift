//
//  NavigationBarModifier.swift
//  DesignSystem
//
//  Created by eunseou on 12/30/24.
//

import SwiftUI

public enum NavigationType {
  case main
  case subBack
  case subClose
  case feature
}


struct NavigationBarModifier: ViewModifier {
  private var navigationBar: NavigationBar
  
  init(
    navigationBar: NavigationBar
  ) {
    self.navigationBar = navigationBar
  }
  
  func body(content: Content) -> some View {
    VStack(spacing: 0) {
      navigationBar
      
      content
    }
    .navigationBarHidden(true)
  }
}

public extension SwiftUI.View {
  func navigationBarModifier(navigationBar: () -> NavigationBar) -> some View {
    modifier(NavigationBarModifier(navigationBar: navigationBar()))
  }
}
