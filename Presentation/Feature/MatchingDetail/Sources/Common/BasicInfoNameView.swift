//
//  BasicInfoNameView.swift
//  MatchingDetail
//
//  Created by summercat on 1/5/25.
//

import DesignSystem
import SwiftUI

struct BasicInfoNameView: View {
  init(
    shortIntroduction: String,
    nickname: String,
    moreButtonAction: @escaping () -> Void
  ) {
    self.shortIntroduction = shortIntroduction
    self.nickname = nickname
    self.moreButtonAction = moreButtonAction
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(shortIntroduction)
        .pretendard(.body_M_R)
        .foregroundStyle(Color.grayscaleBlack)
      
      HStack(alignment: .center) {
        Text(nickname)
          .pretendard(.heading_L_SB)
          .foregroundStyle(Color.primaryDefault)
        Spacer()
        Button {
          moreButtonAction()
        } label: {
          DesignSystemAsset.Icons.more32.swiftUIImage
            .renderingMode(.template)
            .foregroundStyle(Color.grayscaleBlack)
        }
      }
    }
  }
  
  private let shortIntroduction: String
  private let nickname: String
  private let moreButtonAction: () -> Void
}

#Preview {
  BasicInfoNameView(
    shortIntroduction: "음악과 요리를 좋아하는",
    nickname: "수줍은 수달",
    moreButtonAction: { }
  )
}
