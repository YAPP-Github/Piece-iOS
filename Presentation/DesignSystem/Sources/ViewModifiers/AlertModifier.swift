//
//  AlertModifier.swift
//  DesignSystem
//
//  Created by summercat on 1/30/25.
//

import SwiftUI

public struct AlertModifier: ViewModifier {
  @Binding var isPresented: Bool
  
  let alert: AlertView
  
  public func body(content: Content) -> some View {
    content
      .fullScreenCover(isPresented: $isPresented) {
        ZStack {
          Dimmer()
          alert
        }
      }
      .transaction { transaction in
        transaction.disablesAnimations = true
      }
  }
}

public extension View {
  func pcAlert(
    isPresented: Binding<Bool>,
    alert: @escaping () -> AlertView
  ) -> some View {
    return modifier(AlertModifier(isPresented: isPresented, alert: alert()))
  }
}
