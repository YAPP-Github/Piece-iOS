//
//  TextCountIndicator.swift
//  SignUp
//
//  Created by summercat on 2/9/25.
//

import SwiftUI

public struct TextCountIndicator: View {
  @Binding public var count: Int
  private let maxCount: Int
  
  public init(count: Binding<Int>, maxCount: Int) {
    self._count = count
    self.maxCount = maxCount
  }
  
  public var body: some View {
    HStack(spacing: 0) {
      Text(count.description)
        .pretendard(.body_S_M)
        .foregroundStyle(Color.primaryDefault)
      Text("/\(maxCount)")
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark3)
    }
    .frame(maxWidth: .infinity, alignment: .trailing)
  }
}

#Preview {
  TextCountIndicator(count: .constant(150), maxCount: 300)
}
