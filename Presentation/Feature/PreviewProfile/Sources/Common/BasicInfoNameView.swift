//
//  BasicInfoNameView.swift
//  PreviewProfile
//
//  Created by summercat on 1/5/25.
//

import DesignSystem
import SwiftUI

struct BasicInfoNameView: View {
  init(
    shortIntroduction: String,
    nickname: String
  ) {
    self.shortIntroduction = shortIntroduction
    self.nickname = nickname
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(shortIntroduction)
        .pretendard(.body_M_R)
        .foregroundStyle(Color.grayscaleBlack)
      
      Text(nickname)
        .pretendard(.heading_L_SB)
        .foregroundStyle(Color.primaryDefault)
    }
  }
  
  private let shortIntroduction: String
  private let nickname: String
}

#Preview {
  BasicInfoNameView(
    shortIntroduction: "음악과 요리를 좋아하는",
    nickname: "수줍은 수달"
  )
}
