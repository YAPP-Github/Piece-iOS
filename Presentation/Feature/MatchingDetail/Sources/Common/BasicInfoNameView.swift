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
    shortIntroduce: String,
    nickname: String,
    moreButtonAction: @escaping () -> Void
  ) {
    self.shortIntroduce = shortIntroduce
    self.nickname = nickname
    self.moreButtonAction = moreButtonAction
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(shortIntroduce)
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
  
  private let shortIntroduce: String
  private let nickname: String
  private let moreButtonAction: () -> Void
}

#Preview {
  BasicInfoNameView(
    shortIntroduce: "음악과 요리를 좋아하는",
    nickname: "수줍은 수달",
    moreButtonAction: { }
  )
}
