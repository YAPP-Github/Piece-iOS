//
// MatchingDetailBasicInfoViewModel.swift
// MatchingDetail
//
// Created by summercat on 2025/01/02.
//

import Observation

@Observable
final class MatchingDetailBasicInfoViewModel {
  enum Constant {
    static let title = "오늘의 매칭 조각"
  }
  
  enum Action {
    case didTapMoreButton
    case didTapNextButton
  }
  
  @ObservationIgnored let title = Constant.title
  var matchingBasicInfoModel: MatchingBasicInfoModel
  
  init(matchingBasicInfoModel: MatchingBasicInfoModel) {
    self.matchingBasicInfoModel = matchingBasicInfoModel
  }
  
  func handleAction(_ action: Action) {
    
  }
}
