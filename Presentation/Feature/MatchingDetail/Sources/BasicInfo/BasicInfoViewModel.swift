//
// BasicInfoViewModel.swift
// MatchingDetail
//
// Created by summercat on 2025/01/02.
//

import Observation
import UseCases

@Observable
final class BasicInfoViewModel {
  private enum Constant {
    static let navigationTitle = ""
    static let title = "오늘의 매칭 조각"
  }
  
  enum Action {
    case didTapCloseButton
    case didTapMoreButton
    case didTapNextButton
  }

  let navigationTitle = Constant.navigationTitle
  let title = Constant.title
  private(set) var basicInfoModel: BasicInfoModel?
  private let getMatchProfileBasicUseCase: GetMatchProfileBasicUseCase
  
  init(getMatchProfileBasicUseCase: GetMatchProfileBasicUseCase) {
    self.getMatchProfileBasicUseCase = getMatchProfileBasicUseCase
  }
  
  func handleAction(_ action: Action) {
  }
}
