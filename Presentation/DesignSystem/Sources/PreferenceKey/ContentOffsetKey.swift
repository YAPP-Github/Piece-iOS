//
//  ContentOffsetKey.swift
//  DesignSystem
//
//  Created by summercat on 1/5/25.
//

import SwiftUI

struct ContentOffsetKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}
