//
//  RoundedButton.swift
//  DesignSystem
//
//  Created by summercat on 12/22/24.
//

import SwiftUI

public struct RoundedButton: View {
  public enum ButtonType {
    case solid
    case outline
    case sub
    case disabled
    
    var backgroundColor: Color {
      switch self {
      case .solid: .primaryDefault
      case .outline: .grayscaleWhite
      case .sub: .primaryLight
      case .disabled: .grayscaleLight1
      }
    }
    
    var borderColor: Color {
      switch self {
      case .solid: .primaryDefault
      case .outline: .primaryDefault
      case .sub: .primaryLight
      case .disabled: .clear
      }
    }
    
    var contentColor: Color {
      switch self {
      case .solid: .grayscaleWhite
      case .outline: .primaryDefault
      case .sub: .primaryDefault
      case .disabled: .grayscaleWhite
      }
    }
  }
  
  public init(
    type: ButtonType,
    buttonText: String,
    icon: Image?,
    height: CGFloat? = 52,
    action: @escaping () -> Void
  ) {
    self.type = type
    self.buttonText = buttonText
    self.icon = icon
    self.height = height
    self.action = action
  }
  
  public var body: some View {
    Button {
      action()
    } label: {
      HStack(alignment: .center, spacing: 8) {
        if let icon {
          icon
            .renderingMode(.template)
            .foregroundStyle(type.contentColor)
        }
        Text(buttonText)
          .pretendard(.body_M_SB)
          .foregroundStyle(type.contentColor)
      }
      .frame(height: height)
      .frame(maxWidth: .infinity)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .foregroundStyle(type.backgroundColor)
      )
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .strokeBorder(type.borderColor, lineWidth: 1)
      )
    }
  }
  
  private let type: ButtonType
  private let buttonText: String
  private let icon: Image?
  private let height: CGFloat?
  private let action: () -> Void
}

#Preview {
  VStack {
    RoundedButton(
      type: .solid,
      buttonText: "Solid",
      icon: nil,
      action: {
      })
    RoundedButton(
      type: .solid,
      buttonText: "Solid w/ icon",
      icon: DesignSystemAsset.Icons.question20.swiftUIImage,
      action: {
      })
    RoundedButton(
      type: .outline,
      buttonText: "Outline w/ icon",
      icon: DesignSystemAsset.Icons.question20.swiftUIImage,
      action: {
      })
    RoundedButton(
      type: .sub,
      buttonText: "Sub",
      icon: nil,
      action: {
      })
    RoundedButton(
      type: .sub,
      buttonText: "Sub w/ icon",
      icon: DesignSystemAsset.Icons.question20.swiftUIImage,
      action: {
      })
    RoundedButton(
      type: .disabled,
      buttonText: "Disabled",
      icon: DesignSystemAsset.Icons.question20.swiftUIImage,
      action: {
      })
    RoundedButton(
      type: .disabled,
      buttonText: "Disabled w/ icon",
      icon: DesignSystemAsset.Icons.question20.swiftUIImage,
      action: {
      })
  }
}
