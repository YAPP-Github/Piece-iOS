//
//  ValuePickViewModel.swift
//  MatchingDetail
//
//  Created by summercat on 1/13/25.
//

import Foundation
import Observation
import UseCases

@Observable
final class ValuePickViewModel {
  private enum Constant {
    static let navigationTitle = "가치관 Pick"
    static let nameVisibilityOffset: CGFloat = -100
  }
  
  enum Action {
    case contentOffsetDidChange(CGFloat)
    case didTapMoreButton
    case didSelectTab(ValuePickTab)
    case didTapPhotoButton
    case didTapAcceptButton
    case didTapRefuseButton
    case didAcceptMatch
    case didRefuseMatch
  }
  
  init(
    getMatchValuePickUseCase: GetMatchValuePickUseCase,
    getMatchPhotoUseCase: GetMatchPhotoUseCase,
    acceptMatchUseCase: AcceptMatchUseCase,
    refuseMatchUseCase: RefuseMatchUseCase
  ) {
    self.getMatchValuePickUseCase = getMatchValuePickUseCase
    self.getMatchPhotoUseCase = getMatchPhotoUseCase
    self.acceptMatchUseCase = acceptMatchUseCase
    self.refuseMatchUseCase = refuseMatchUseCase
    
    Task {
      await fetchMatchValueTalk()
      await fetchMatchPhoto()
    }
  }
  
  let tabs = ValuePickTab.allCases
  let navigationTitle: String = Constant.navigationTitle
  var isPhotoViewPresented: Bool = false
  var isMatchAcceptAlertPresented: Bool = false
  var isMatchDeclineAlertPresented: Bool = false
  
  private(set) var valuePickModel: ValuePickModel?
  private(set) var isLoading = true
  private(set) var error: Error?
  private(set) var contentOffset: CGFloat = 0
  private(set) var isNameViewVisible: Bool = true
  private(set) var selectedTab: ValuePickTab = .all
  private(set) var displayedValuePicks: [ValuePickAnswerModel] = []
  private(set) var sameWithMeCount: Int = 0
  private(set) var differentFromMeCount: Int = 0
  private(set) var photoUri: String = ""
  private var valuePicks: [ValuePickAnswerModel] = []
  private let getMatchValuePickUseCase: GetMatchValuePickUseCase
  private let getMatchPhotoUseCase: GetMatchPhotoUseCase
  private let acceptMatchUseCase: AcceptMatchUseCase
  private let refuseMatchUseCase: RefuseMatchUseCase
  
  func handleAction(_ action: Action) {
    switch action {
    case let .contentOffsetDidChange(offset):
      contentOffset = offset
      isNameViewVisible = offset > Constant.nameVisibilityOffset
      
    case .didTapMoreButton:
      return
      
    case let .didSelectTab(tab):
      self.selectedTab = tab
      switch tab {
      case .all:
        displayedValuePicks = valuePicks
      case .same:
        displayedValuePicks = valuePicks.filter { $0.sameWithMe }
      case .different:
        displayedValuePicks = valuePicks.filter { !$0.sameWithMe }
      }
      
    case .didTapPhotoButton:
      isPhotoViewPresented = true
      
    case .didTapAcceptButton:
      isMatchAcceptAlertPresented = true
      
    case .didTapRefuseButton:
      isMatchDeclineAlertPresented = true
      
    case .didAcceptMatch:
      Task { await acceptMatch() }
      isMatchAcceptAlertPresented = false
      
    case .didRefuseMatch:
      Task { await refuseMatch() }
      isMatchDeclineAlertPresented = false
    }
  }
  
  func fetchMatchValueTalk() async {
    do {
      let entity = try await getMatchValuePickUseCase.execute()
      let model = ValuePickModel(
        id: entity.id,
        shortIntroduction: entity.description,
        nickname: entity.nickname,
        valuePicks: entity.valuePicks.map {
          ValuePickAnswerModel(
            id: UUID(),
            category: $0.category,
            question: $0.question,
            sameWithMe: $0.sameWithMe
          )
        }
      )
      valuePickModel = model
      valuePicks = model.valuePicks
      displayedValuePicks = model.valuePicks
      sameWithMeCount = entity.valuePicks.filter { $0.sameWithMe }.count
      differentFromMeCount = entity.valuePicks.filter { !$0.sameWithMe }.count
      
      error = nil
    } catch {
      self.error = error
    }
    
    isLoading = false
  }
  
  private func fetchMatchPhoto() async {
    do {
      let uri = try await getMatchPhotoUseCase.execute()
      photoUri = uri
    } catch {
      self.error = error
    }
  }
  
  private func acceptMatch() async {
    do {
      _ = try await acceptMatchUseCase.execute()
    } catch {
      self.error = error
    }
  }
  
  private func refuseMatch() async {
    do {
      _ = try await refuseMatchUseCase.execute()
    } catch {
      self.error = error
    }
  }
}
