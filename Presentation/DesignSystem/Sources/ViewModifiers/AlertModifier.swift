//
//  AlertModifier.swift
//  DesignSystem
//
//  Created by summercat on 1/30/25.
//

import SwiftUI

public struct AlertModifier<Title: View>: ViewModifier {
  @Binding var isPresented: Bool
  
  let alert: AlertView<Title>
  
  public func body(content: Content) -> some View {
    content
      .fullScreenCover(isPresented: $isPresented) {
        alert
          .background(
            Dimmer()
              .ignoresSafeArea()
          )
      }
  }
}

public extension View {
  func pcAlert<Title: View>(
    isPresented: Binding<Bool>,
    alert: @escaping () -> AlertView<Title>
  ) -> some View {
    return modifier(AlertModifier(isPresented: isPresented, alert: alert()))
  }
}
