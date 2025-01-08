//
//  MatchingMainView.swift
//  MatchingMain
//
//  Created by eunseou on 12/28/24.
//

import SwiftUI
import DesignSystem

struct MatchingMainView: View {
  @Bindable var matchingTimerViewModel: MatchingTimerViewModel
  @Bindable var matchingMainViewModel: MatchingMainViewModel
  
  public var body: some View {
    ZStack {
      Color.grayscaleBlack.edgesIgnoringSafeArea(.all)
      VStack {
        MatchingTimer(matchingTimerViewModel: matchingTimerViewModel)
      }
      .padding(.horizontal, 20)
    }
  }
  
    }
  }
}

#Preview {
  MatchingMainView(
    matchingTimerViewModel: MatchingTimerViewModel(),
    matchingMainViewModel: MatchingMainViewModel()
  )
}
