//
//  MatchingMainView.swift
//  MatchingMain
//
//  Created by eunseou on 12/28/24.
//

import SwiftUI
import Combine
import DesignSystem

struct MatchingMainView: View {
  let matchingTimerViewModel: MatchingTimerViewModel
  let matchingMainViewModel: MatchingMainViewModel
  
  public var body: some View {
    ZStack {
      Color.grayscaleBlack.edgesIgnoringSafeArea(.all)
      VStack {
        MatchingTimerView(matchingTimerViewModel: matchingTimerViewModel)
        MatchingProfileCardView(matchingMainViewModel: matchingMainViewModel)
      }
      .padding(.horizontal, 20)
    }
  }
}

// MARK: - 타이머
private struct MatchingTimerView: View {
  @ObservedObject var matchingTimerViewModel: MatchingTimerViewModel
  
  var body: some View {
    HStack(spacing: 4) {
      Text("소중한 인연이 사라지기까지")
      Text(matchingTimerViewModel.state.timeString)
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

#Preview {
  MatchingMainView(
    matchingTimerViewModel: MatchingTimerViewModel(),
    matchingMainViewModel: MatchingMainViewModel()
  )
}
