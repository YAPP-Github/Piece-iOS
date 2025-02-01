//
//  ValueTalkViewModel.swift
//  MatchingDetail
//
//  Created by summercat on 1/5/25.
//

import Foundation
import Observation
import UseCases

@Observable
final class ValueTalkViewModel {
  private enum Constant {
    static let navigationTitle = "가치관 Talk"
    static let nameVisibilityOffset: CGFloat = -80
  }
  
  enum Action {
    case contentOffsetDidChange(CGFloat)
    case didTapMoreButton
  }
  
  init(getMatchValueTalkUseCase: GetMatchValueTalkUseCase) {
    self.getMatchValueTalkUseCase = getMatchValueTalkUseCase
  }
  
  var navigationTitle: String = Constant.navigationTitle
  var valueTalkModel: ValueTalkModel?
  var contentOffset: CGFloat = 0
  var isNameViewVisible: Bool = true
  private let getMatchValueTalkUseCase: GetMatchValueTalkUseCase
  
  func handleAction(_ action: Action) {
    switch action {
    case let .contentOffsetDidChange(offset):
      contentOffset = offset
      isNameViewVisible = offset > Constant.nameVisibilityOffset
      
    default: return
    }
  }
}
