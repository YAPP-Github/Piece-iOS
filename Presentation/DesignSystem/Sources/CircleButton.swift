//
//  CircleButton.swift
//  DesignSystem
//
//  Created by summercat on 1/2/25.
//

import SwiftUI

public struct CircleButton: View {
  public enum ButtonType {
    case solid_primary
    case solid_white
    case outline
    case disabled
    
    var backgroundColor: Color {
      switch self {
      case .solid_primary: .primaryDefault
      case .solid_white: .grayscaleWhite
      case .outline: .grayscaleWhite
      case .disabled: .grayscaleLight1
      }
    }
    
    var borderColor: Color {
      switch self {
      case .solid_primary: .primaryDefault
      case .solid_white: .grayscaleWhite
      case .outline: .primaryDefault
      case .disabled: .clear
      }
    }
    
    var contentColor: Color {
      switch self {
      case .solid_primary: .grayscaleWhite
      case .solid_white: .primaryDefault
      case .outline: .primaryDefault
      case .disabled: .grayscaleWhite
      }
    }
  }
  
  public init(
    type: ButtonType,
    icon: Image,
    action: @escaping () -> Void
  ) {
    self.type = type
    self.icon = icon
    self.action = action
  }
  
  public var body: some View {
    Button {
      action()
    } label: {
      Circle()
        .foregroundStyle(type.backgroundColor)
        .frame(width: 52, height: 52)
        .overlay {
          icon
            .renderingMode(.template)
            .foregroundStyle(type.contentColor)
        }
        .overlay {
          Circle()
            .strokeBorder(type.borderColor, lineWidth: 1)
        }
    }
    .disabled(type == .disabled)
  }
  
  private let type: ButtonType
  private let icon: Image
  private let action: () -> Void
}

#Preview {
  VStack {
    CircleButton(
      type: .solid_primary,
      icon: DesignSystemAsset.Icons.arrowRight32.swiftUIImage,
      action: { }
    )
    CircleButton(
      type: .outline,
      icon: DesignSystemAsset.Icons.arrowRight32.swiftUIImage,
      action: { }
    )
    CircleButton(
      type: .disabled,
      icon: DesignSystemAsset.Icons.arrowRight32.swiftUIImage,
      action: { }
    )
  }
}
