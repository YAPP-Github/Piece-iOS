//
//  Dimmer.swift
//  DesignSystem
//
//  Created by summercat on 1/30/25.
//

import SwiftUI

public struct Dimmer: View {
  public init() { }
  
  public var body: some View {
    Rectangle()
      .fill(Color.alphaBlack40)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .ignoresSafeArea()
  }
}

#Preview {
  Dimmer()
}
