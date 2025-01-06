//
//  NavigationBarModifier.swift
//  DesignSystem
//
//  Created by eunseou on 12/30/24.
//

import SwiftUI

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

#Preview {
  ZStack {
    Color.grayscaleWhite.ignoresSafeArea()
    VStack{
      Text("Hello")
    }
  }
  .navigationBarModifier {
    NavigationBar(
      title: "Feature",
      titleColor: .grayscaleWhite,
      leftButtonTap: {},
      backgroundColor: .grayscaleBlack
    )
  }
}
