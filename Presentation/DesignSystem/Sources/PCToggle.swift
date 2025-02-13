//
//  Toggle.swift
//  DesignSystem
//
//  Created by summercat on 2/11/25.
//

import SwiftUI

public struct PCToggle: View {

  @Binding public var isOn: Bool
  
  public init(isOn: Binding<Bool>) {
    self._isOn = isOn
  }

  public var body: some View {
    Capsule()
      .fill(isOn ? Color.primaryDefault : Color.grayscaleLight1)
      .frame(width: 32.0, height: 20.0)
      .overlay {
        GeometryReader { proxy in
          RoundedRectangle(cornerRadius: 8.0, style: .circular)
            .fill(Color.grayscaleWhite)
            .frame(width: 16.0, height: 16.0)
            .offset(x: isOn ? proxy.size.width - 16.0 - 2.0 : 2.0)
            .padding(.vertical, 2.0)
        }
      }
      .onTapGesture {
        withAnimation {
          isOn.toggle()
        }
      }
      .padding(.horizontal, 3.0)
      .padding(.vertical, 6.0)
  }
}

#Preview {
  @Previewable @State var isOn: Bool = true
  PCToggle(isOn: $isOn)
}

