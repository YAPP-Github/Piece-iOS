//
//  MaxLengthModifier.swift
//  DesignSystem
//
//  Created by summercat on 3/24/25.
//

import SwiftUI

struct MaxLengthModifier: ViewModifier {
  @Binding var text: String
  let maxLength: Int
  
  func body(content: Content) -> some View {
    content
      .onChange(of: text) { oldValue, newValue in
        if newValue.count > maxLength {
          text = oldValue
        }
      }
  }
}

public extension TextField {
  /// TextField 에서 최대 글자수를 정하기 위한 Modifier
  func maxLength(text: Binding<String>, _ maxLength: Int) -> some View {
    return ModifiedContent(
      content: self,
      modifier: MaxLengthModifier(
        text: text,
        maxLength: maxLength)
    )
  }
}
