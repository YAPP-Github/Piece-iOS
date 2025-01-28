//
//  ValueTalkViewModel.swift
//  MatchingDetail
//
//  Created by summercat on 1/5/25.
//

import Foundation
import Observation

@Observable
final class ValueTalkViewModel {
  private enum Constant {
    static let navigationTitle = "가치관 Talk"
    static let nameVisibilityOffset: CGFloat = -80
  }
  
  enum Action {
    case contentOffsetDidChange(CGFloat)
    case didTapCloseButton
    case didTapMoreButton
    case didTapPreviousButton
    case didTapNextButton
  }
  
  init(valueTalkModel: ValueTalkModel) {
    self.valueTalkModel = valueTalkModel
  }
  
  var navigationTitle: String = Constant.navigationTitle
  var valueTalkModel: ValueTalkModel
  var contentOffset: CGFloat = 0
  var isNameViewVisible: Bool = true
  
  func handleAction(_ action: Action) {
    switch action {
    case let .contentOffsetDidChange(offset):
      contentOffset = offset
      isNameViewVisible = offset > Constant.nameVisibilityOffset
      
    default: return
    }
  }
}
