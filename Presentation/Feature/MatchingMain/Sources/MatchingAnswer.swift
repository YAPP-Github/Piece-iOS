//
//  MatchingAnswer.swift
//  DesignSystem
//
//  Created by eunseou on 12/31/24.
//

import SwiftUI
import DesignSystem

public struct MatchingAnswer: View {
  public enum MatchingStatus {
    case before
    case waiting
    case done
    case complete
    case green_light
    
    var icon: Image {
      switch self {
      case .before, .waiting: DesignSystemAsset.Icons.matchingModeLoading20.swiftUIImage
      case .done, .complete: DesignSystemAsset.Icons.matchingModeCheck20.swiftUIImage
      case .green_light: DesignSystemAsset.Icons.matchingModeHeart20.swiftUIImage
      }
    }
    
    var title: String {
      switch self {
      case .before: "오픈 전"
      case .waiting: "응답 대기중"
      case .done: "응답 완료"
      case .complete: "매칭 완료"
      case .green_light: "그린라이트"
      }
    }
    
    var titleTextColor: Color {
      switch self {
      case .before, .waiting: .grayscaleDark2
      case .done, .complete, .green_light: .primaryDefault
      }
    }
    
    var description: String {
      switch self {
      case .before: "매칭 조각을 확인해주세요!"
      case .waiting: "매칭에 응답해주세요!"
      case .done: "상대방의 응답을 기다려봐요!"
      case .complete: "상대방과 연결되었어요!"
      case .green_light: "상대방이 매칭을 수락했어요!"
      }
    }
  }
  
  public init(type: MatchingStatus) {
    self.type = type
  }
  
  public var body: some View {
    HStack(spacing: 8) {
      type.icon
      Text(type.title)
        .pretendard(.body_S_SB)
        .foregroundColor(type.titleTextColor)
      Text(type.description)
        .pretendard(.body_S_M)
        .foregroundColor(.grayscaleDark3)
    }
  }
  
  private let type: MatchingStatus
}

#Preview {
  VStack {
    MatchingAnswer(type: .before)
    MatchingAnswer(type: .waiting)
    MatchingAnswer(type: .done)
    MatchingAnswer(type: .complete)
    MatchingAnswer(type: .green_light)
  }
}
