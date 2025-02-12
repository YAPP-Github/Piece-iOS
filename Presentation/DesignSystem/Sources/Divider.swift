//
//  Divider.swift
//  DesignSystem
//
//  Created by summercat on 12/22/24.
//

import SwiftUI

public struct Divider: View {
  public enum Weight {
    case normal
    case thick
    
    var value: CGFloat {
      switch self {
      case .normal: 1
      case .thick: 12
      }
    }
  }
  
  public init(
    weight: Weight,
    isVertical: Bool = false
  ) {
    self.weight = weight.value
    self.isVertical = isVertical
  }
  
  public var body: some View {
    if isVertical {
      verticalDivider
    } else {
      horizontalDivider
    }
  }
  
  private var verticalDivider: some View {
    Rectangle()
      .foregroundStyle(Color.grayscaleLight3)
      .frame(width: weight)
  }
  
  private var horizontalDivider: some View {
    Rectangle()
      .foregroundStyle(Color.grayscaleLight3)
      .frame(height: weight)
  }
  
  private let weight: CGFloat
  private let isVertical: Bool
}

#Preview {
  VStack {
    Divider(weight: .normal, isVertical: false)
    Divider(weight: .thick, isVertical: false)
    Divider(weight: .normal, isVertical: true)
  }
}
