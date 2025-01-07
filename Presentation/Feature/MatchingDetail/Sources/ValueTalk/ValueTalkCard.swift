//
//  ValueTalkCard.swift
//  MatchingDetail
//
//  Created by summercat on 1/5/25.
//

import DesignSystem
import SwiftUI

struct ValueTalkCard: View {
  init(topic: String, summary: String, answer: String, image: Image) {
    self.topic = topic
    self.summary = summary
    self.answer = answer
    self.image = image
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 24) {
      Text(topic)
        .pretendard(.body_M_M)
        .foregroundStyle(Color.primaryDefault)
      
      image
        .resizable()
        .frame(width: 60, height: 60)
      
      content
    }
    .padding(.horizontal, 20)
    .padding(.top, 20)
    .padding(.bottom, 32)
    .background(
      RoundedRectangle(cornerRadius: 12)
        .fill(Color.grayscaleWhite)
    )
  }
  
  private var content: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(summary)
        .multilineTextAlignment(.leading)
        .pretendard(.heading_M_SB)
        .foregroundStyle(Color.grayscaleBlack)
      
      Text(answer)
        .multilineTextAlignment(.leading)
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark2)
    }
  }
  
  private let topic: String
  private let summary: String
  private let answer: String
  private let image: Image
}

#Preview {
  ValueTalkCard(
    topic: "꿈과 목표",
    summary: "여행하며 문화 경험, LGBTQ+ 변화를 원해요.",
    answer: "안녕하세요! 저는 삶의 매 순간을 소중히 여기며, 꿈과 목표를 이루기 위해 노력하는 사람입니다. 제 가장 큰 꿈은 여행을 통해 다양한 문화와 사람들을 경험하고, 그 과정에서 얻은 지혜를 나누는 것입니다. 또한, LGBTQ+ 커뮤니티를 위한 긍정적인 변화를 이끌어내고 싶습니다. 내가 이루고자 하는 목표는 나 자신을 발전시키고, 사랑하는 사람들과 함께 행복한 순간들을 만드는 것입니다. 서로의 꿈을 지지하며 함께 성장할 수 있는 관계를 기대합니다!",
    image: DesignSystemAsset.Icons.alarm32.swiftUIImage
  )
}
