//
//  Color.swift
//  DesignSystem
//
//  Created by summercat on 12/22/24.
//

import SwiftUI

public extension Color {
  static let grayscaleBlack = DesignSystemAsset.Colors.grayscaleBlack.swiftUIColor
  static let grayscaleDark1 = DesignSystemAsset.Colors.grayscaleDark1.swiftUIColor
  static let grayscaleDark2 = DesignSystemAsset.Colors.grayscaleDark2.swiftUIColor
  static let grayscaleDark3 = DesignSystemAsset.Colors.grayscaleDark3.swiftUIColor
  static let grayscaleLight1 = DesignSystemAsset.Colors.grayscaleLight1.swiftUIColor
  static let grayscaleLight2 = DesignSystemAsset.Colors.grayscaleLight2.swiftUIColor
  static let grayscaleLight3 = DesignSystemAsset.Colors.grayscaleLight3.swiftUIColor
  static let grayscaleWhite = DesignSystemAsset.Colors.grayscaleWhite.swiftUIColor
  static let primaryDefault = DesignSystemAsset.Colors.primaryDefault.swiftUIColor
  static let primaryLight = DesignSystemAsset.Colors.primaryLight.swiftUIColor
  static let primaryMiddle = DesignSystemAsset.Colors.primaryMiddle.swiftUIColor
  static let subDefault = DesignSystemAsset.Colors.subDefault.swiftUIColor
  static let subLight = DesignSystemAsset.Colors.subLight.swiftUIColor
  static let subMiddle = DesignSystemAsset.Colors.subMiddle.swiftUIColor
  static let alphaWhite10 = DesignSystemAsset.Colors.alphaWhite10.swiftUIColor
  static let alphaWhite60 = DesignSystemAsset.Colors.alphaWhite60.swiftUIColor
  static let alphaBlack40 = DesignSystemAsset.Colors.alphaBlack40.swiftUIColor
  static let systemError = DesignSystemAsset.Colors.systemError.swiftUIColor
}

public extension ShapeStyle where Self == Color {
    static var grayscaleBlack: Color { DesignSystemAsset.Colors.grayscaleBlack.swiftUIColor }
    static var grayscaleDark1: Color { DesignSystemAsset.Colors.grayscaleDark1.swiftUIColor }
    static var grayscaleDark2: Color { DesignSystemAsset.Colors.grayscaleDark2.swiftUIColor }
    static var grayscaleDark3: Color { DesignSystemAsset.Colors.grayscaleDark3.swiftUIColor }
    static var grayscaleLight1: Color { DesignSystemAsset.Colors.grayscaleLight1.swiftUIColor }
    static var grayscaleLight2: Color { DesignSystemAsset.Colors.grayscaleLight2.swiftUIColor }
    static var grayscaleLight3: Color { DesignSystemAsset.Colors.grayscaleLight3.swiftUIColor }
    static var grayscaleWhite: Color { DesignSystemAsset.Colors.grayscaleWhite.swiftUIColor }
    static var primaryDefault: Color { DesignSystemAsset.Colors.primaryDefault.swiftUIColor }
    static var primaryLight: Color { DesignSystemAsset.Colors.primaryLight.swiftUIColor }
    static var primaryMiddle: Color { DesignSystemAsset.Colors.primaryMiddle.swiftUIColor }
    static var subDefault: Color { DesignSystemAsset.Colors.subDefault.swiftUIColor }
    static var subLight: Color { DesignSystemAsset.Colors.subLight.swiftUIColor }
    static var subMiddle: Color { DesignSystemAsset.Colors.subMiddle.swiftUIColor }
    static var alphaWhite10: Color { DesignSystemAsset.Colors.alphaWhite10.swiftUIColor }
    static var alphaWhite60: Color { DesignSystemAsset.Colors.alphaWhite60.swiftUIColor }
    static var alphaBlack40: Color { DesignSystemAsset.Colors.alphaBlack40.swiftUIColor }
    static var systemError: Color { DesignSystemAsset.Colors.systemError.swiftUIColor }
}
