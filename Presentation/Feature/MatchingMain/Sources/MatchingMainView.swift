//
//  MatchingMainView.swift
//  MatchingMain
//
//  Created by eunseou on 12/28/24.
//

import SwiftUI
import DesignSystem

public struct MatchingMainView: View {
  public var body: some View {
      
      ZStack {
        Color.grayscaleBlack.edgesIgnoringSafeArea(.all)
        
        VStack {
          MatchingTimerView()

          MatchingProfileCardView()
        }
        .padding(.horizontal, 20)
        
      }
    }
}

// MARK: - 타이머
private struct MatchingTimerView: View {
  var body: some View {
    HStack(spacing: 4) {
      Text("소중한 인연이 사라지기까지")
      Text("00:00:00")
        .pretendard(.body_S_SB)
        .foregroundColor(.subDefault)
      Text("남았어요")
    }
    .pretendard(.body_S_M)
    .foregroundColor(.grayscaleLight1)
    .padding(.vertical, 12)
    .padding(.horizontal, 33)
    .fixedSize(horizontal: true, vertical: false)
    .background(Color.grayscaleWhite.opacity(0.1))
    .cornerRadius(8)
  }
}

// MARK: - 프로필 카드
private struct MatchingProfileCardView: View {
  var body: some View {
    VStack(alignment: .leading) {
        MatchingAnswer(type: .before)
      
      Spacer()
        .frame(height: 20)
      
      ProfileBasicButton()
      
      Divider(weight: .normal, isVertical: false)
      
      HStack(spacing: 4) {
        Text("나와 같은 가치관")
        Text("7개")
          .foregroundColor(.primaryDefault)
      }
      .pretendard(.body_M_M)
      .foregroundColor(.grayscaleBlack)
      
      ScrollView(.vertical, showsIndicators: true) {
        VStack(alignment: .leading, spacing: 8) {
          Tag(badgeText: "바깥 데이트 스킨십 가능")
          Tag(badgeText: "함께 술을 즐기고 싶어요")
          Tag(badgeText: "연락은 바쁘더라도 자주")
          Tag(badgeText: "최대 너비 260. 두 줄 노출 가능. 최대 너비 260. 두 줄 노출 가능.")
          Tag(badgeText: "바깥 데이트 스킨십 가능")
          Tag(badgeText: "함께 술을 즐기고 싶어요")
          Tag(badgeText: "연락은 바쁘더라도 자주")
        }
        .lineLimit(2)
        .truncationMode(.tail)
        .frame(maxWidth: 260, alignment: .leading)
        .padding(.trailing, 35)
        .background(Color.yellow.opacity(0.3))
      }
      
      RoundedButton(
        type: .solid,
        buttonText: "매칭수락하기",
        icon: nil,
        height: 52,
        action: {
        })
      
    }
    .padding(.vertical, 20)
    .padding(.horizontal, 20)
    .background(
      Rectangle()
        .fill(Color.grayscaleWhite)
        .cornerRadius(16)
    )
  }
}

// MARK: - 프로필 카드 내부 버튼
private struct ProfileBasicButton: View {
  var body: some View {
    Text("음악과 요리를 좋아하는 수줍은 수달입니다")
      .pretendard(.heading_L_SB)
    
    Spacer()
      .frame(height: 12)
    
    HStack(spacing: 8) {
      Text("02년생")
      Divider(weight: .normal, isVertical: true)
        .frame(height: 12)
      Text("광주광역시")
      Divider(weight: .normal, isVertical: true)
        .frame(height: 12)
      Text("학생")
    }
    .pretendard(.body_M_M)
    .foregroundColor(.grayscaleDark2)
  }
}

#Preview {
  MatchingMainView()
}
