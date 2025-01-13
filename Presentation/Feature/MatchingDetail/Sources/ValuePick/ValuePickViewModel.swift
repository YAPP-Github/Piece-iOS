//
//  ValuePickViewModel.swift
//  MatchingDetail
//
//  Created by summercat on 1/13/25.
//

import Foundation

enum ValuePickTab: CaseIterable, Identifiable {
  case all
  case same
  case different
  
  var id: String {
    return self.description
  }
  
  var description: String {
    switch self {
    case .all: "전체"
    case .same: "나와 같은"
    case .different: "나와 다른"
    }
  }
}

@Observable
final class ValuePickViewModel {
  private enum Constant {
    static let navigationTitle = "가치관 Pick"
    static let nameVisibilityOffset: CGFloat = -100
  }
  
  enum Action {
    case contentOffsetDidChange(CGFloat)
    case didTapCloseButton
    case didTapMoreButton
    case didSelectTab(ValuePickTab)
    case didTapPhotoButton
    case didTapPreviousButton
    case didTapAcceptButton
  }
  
  init(
    description: String,
    nickname: String,
    valuePicks: [ValuePickModel]
  ) {
    self.description = description
    self.nickname = nickname
    self.valuePicks = valuePicks
    self.selectedTab = .all
    self.displayedValuePicks = valuePicks
  }
  
  let tabs = ValuePickTab.allCases
  
  private(set) var navigationTitle: String = Constant.navigationTitle
  private(set) var description: String
  private(set) var nickname: String
  private(set) var contentOffset: CGFloat = 0
  private(set) var isNameViewVisible: Bool = true
  private(set) var selectedTab: ValuePickTab
  private(set) var displayedValuePicks: [ValuePickModel]
  
  private var valuePicks: [ValuePickModel]

  
  func handleAction(_ action: Action) {
    switch action {
    case let .contentOffsetDidChange(offset):
      contentOffset = contentOffset
      isNameViewVisible = offset > Constant.nameVisibilityOffset
      
    case .didTapCloseButton:
      return
      
    case .didTapMoreButton:
      return
      
    case let .didSelectTab(tab):
      self.selectedTab = tab
      // TODO: - API 확인 후 displayedValuePicks의 값을 변경하는 로직 추가
      
    case .didTapPhotoButton:
      return
      
    case .didTapPreviousButton:
      return
      
    case .didTapAcceptButton:
      return
    }
  }
}
