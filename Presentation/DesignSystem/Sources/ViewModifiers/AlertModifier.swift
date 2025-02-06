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
  func pcAlert<Title: View>(
    isPresented: Binding<Bool>,
    alert: @escaping () -> AlertView<Title>
  ) -> some View {
    return modifier(AlertModifier(isPresented: isPresented, alert: alert()))
  }
}
