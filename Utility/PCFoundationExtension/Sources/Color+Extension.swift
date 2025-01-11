//
//  Color+Extension.swift
//  PCFoundationExtension
//
//  Created by eunseou on 1/11/25.
//

import SwiftUI

public extension Color {
  init(hex: Int, opacity: Double = 1) {
    self.init(
      red: Double((hex >> 16) & 0xff) / 255,
      green: Double((hex >> 08) & 0xff) / 255,
      blue: Double((hex >> 00) & 0xff) / 255,
      opacity: opacity
    )
  }
}
