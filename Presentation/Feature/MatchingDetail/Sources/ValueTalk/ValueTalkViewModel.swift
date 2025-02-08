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
    case didTapPhotoButton
  }
  
  init(
    getMatchValueTalkUseCase: GetMatchValueTalkUseCase,
    getMatchPhotoUseCase: GetMatchPhotoUseCase
  ) {
    self.getMatchValueTalkUseCase = getMatchValueTalkUseCase
    self.getMatchPhotoUseCase = getMatchPhotoUseCase
    
    Task {
      await fetchMatchValueTalk()
      await fetchMatchPhoto()
    }
  }
  
  let navigationTitle: String = Constant.navigationTitle
  var isPhotoViewPresented: Bool = false

  private(set) var valueTalkModel: ValueTalkModel?
  private(set) var contentOffset: CGFloat = 0
  private(set) var isNameViewVisible: Bool = true
  private(set) var isLoading = true
  private(set) var error: Error?
  private(set) var photoUri: String = ""
  private let getMatchValueTalkUseCase: GetMatchValueTalkUseCase
  private let getMatchPhotoUseCase: GetMatchPhotoUseCase
  
  func handleAction(_ action: Action) {
    switch action {
    case let .contentOffsetDidChange(offset):
      contentOffset = offset
      isNameViewVisible = offset > Constant.nameVisibilityOffset
      
    case .didTapPhotoButton:
      isPhotoViewPresented = true
      
    default: return
    }
  }
  
  private func fetchMatchValueTalk() async {
    do {
      let entity = try await getMatchValueTalkUseCase.execute()
      valueTalkModel = ValueTalkModel(
        description: entity.shortIntroduction,
        nickname: entity.nickname,
        valueTalks: entity.valueTalks.map {
          ValueTalk(
            id: UUID(),
            topic: $0.category,
            summary: $0.summary,
            answer: $0.answer
          )
        }
      )
      
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
}
