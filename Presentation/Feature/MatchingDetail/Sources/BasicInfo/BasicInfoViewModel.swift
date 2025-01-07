//
// BasicInfoViewModel.swift
// MatchingDetail
//
// Created by summercat on 2025/01/02.
//

import Observation

@Observable
final class BasicInfoViewModel {
  private enum Constant {
    static let title = "오늘의 매칭 조각"
  }
  
  enum Action {
    case didTapCloseButton
    case didTapMoreButton
    case didTapNextButton
  }
  
  let title = Constant.title
  private(set) var matchingBasicInfoModel: BasicInfoModel
  
  init(matchingBasicInfoModel: BasicInfoModel) {
    self.matchingBasicInfoModel = matchingBasicInfoModel
  }
  
  func handleAction(_ action: Action) {
    
  }
}
