//
//  MatchingMainViewModel.swift
//  MatchingMain
//
//  Created by eunseou on 1/4/25.
//

import SwiftUI
import Observation
import DesignSystem

@Observable
final class MatchingMainViewModel {
  enum MatchingButtonState {
    case checkMatchingPiece // 매칭 조각 확인하기
    case acceptMatching // 매칭 수락하기
    case responseComplete // 응답 완료
    case checkContact // 연락처 확인하기
    
    var title: String {
      switch self {
      case .checkMatchingPiece:
        "매칭 조각 확인하기"
      case .acceptMatching:
        "매칭 수락하기"
      case .responseComplete:
        "응답 완료"
      case .checkContact:
        "연락처 확인하기"
      }
    }
    
    var buttonType: RoundedButton.ButtonType {
      switch self {
      case .checkMatchingPiece, .acceptMatching, .checkContact:
          .solid
      case .responseComplete:
          .disabled
      }
    }
  }
  
  enum Action {
    case tapProfileInfo
    case tapMatchingButton
  }
  
  private(set) var description: String
  private(set) var name: String
  private(set) var age: String
  private(set) var location: String
  private(set) var job: String
  private(set) var tags: [String]
  var buttonTitle: String {
    matchingButtonState.title
  }
  var buttonStatus: RoundedButton.ButtonType {
    matchingButtonState.buttonType
  }
  var matchingButtonState: MatchingButtonState
  var matchingStatus: MatchingAnswer.MatchingStatus
  
  init(
    description: String,
    name: String,
    age: String,
    location: String,
    job: String,
    tags: [String],
    matchingButtonState: MatchingButtonState,
    matchingStatus: MatchingAnswer.MatchingStatus
  ) {
    self.description = description
    self.name = name
    self.age = age
    self.location = location
    self.job = job
    self.tags = tags
    self.matchingButtonState = matchingButtonState
    self.matchingStatus = matchingStatus
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapMatchingButton:
      handleMatchingButtonTap()
    default: return
    }
  }
  
  private func handleMatchingButtonTap() {
    switch MatchingButtonState.self {
    default: return
    }
  }
}
