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
    icon: Image? = nil,
    height: CGFloat? = 52,
    rounding: Bool = false,
    action: @escaping () -> Void
  ) {
    self.type = type
    self.buttonText = buttonText
    self.icon = icon
    self.height = height
    self.rounding = rounding
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
      .padding(.horizontal, rounding ? 28 : 12)
      .background(
        backgroundView
      )
      .overlay(
        border
      )
    }
    .disabled(type == .disabled)
  }
  
  @ViewBuilder
  private var backgroundView: some View {
    if rounding {
      Capsule()
        .foregroundStyle(type.backgroundColor)
    } else {
      RoundedRectangle(cornerRadius: 8)
        .foregroundStyle(type.backgroundColor)
    }
  }
  
  @ViewBuilder
  private var border: some View {
    if rounding {
      Capsule()
        .strokeBorder(type.borderColor, lineWidth: 1)
    } else {
      RoundedRectangle(cornerRadius: 8)
        .strokeBorder(type.borderColor, lineWidth: 1)
    }
  }
  
  private let type: ButtonType
  private let buttonText: String
  private let icon: Image?
  private let height: CGFloat?
  private let rounding: Bool
  private let action: () -> Void
}

#Preview {
  VStack {
    RoundedButton(
      type: .solid,
      buttonText: "Solid",
      icon: nil,
      rounding: true,
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
      type: .outline,
      buttonText: "Outline w/ icon",
      icon: DesignSystemAsset.Icons.question20.swiftUIImage,
      rounding: true,
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
