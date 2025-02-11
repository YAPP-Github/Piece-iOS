//
//  TextCountIndicator.swift
//  SignUp
//
//  Created by summercat on 2/9/25.
//

import DesignSystem
import SwiftUI

struct TextCountIndicator: View {
  @Binding var count: Int
  private let maxCount = 300
  
  var body: some View {
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
  TextCountIndicator(count: .constant(150))
}
