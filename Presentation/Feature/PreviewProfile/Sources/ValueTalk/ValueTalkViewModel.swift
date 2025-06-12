//
//  ValueTalkViewModel.swift
//  PreviewProfile
//
//  Created by summercat on 1/5/25.
//

import Entities
import Foundation
import Observation
import UseCases

@MainActor
@Observable
final class ValueTalkViewModel {
  private enum Constant {
    static let navigationTitle = "가치관 Talk"
    static let nameVisibilityOffset: CGFloat = -80
  }
  
  enum Action {
    case contentOffsetDidChange(CGFloat)
    case didTapPhotoButton
  }
  
  init(
    nickname: String,
    description: String,
    imageUri: String,
    getProfileValueTalksUseCase: GetProfileValueTalksUseCase
  ) {
    self.nickname = nickname
    self.description = description
    self.photoUri = imageUri
    self.getProfileValueTalksUseCase = getProfileValueTalksUseCase
    
    Task {
      await fetchMatchValueTalk()
    }
  }
  
  let navigationTitle: String = Constant.navigationTitle
  let nickname: String
  let description: String
  var isPhotoViewPresented: Bool = false

  private(set) var valueTalks: [ValueTalk] = []
  private(set) var contentOffset: CGFloat = 0
  private(set) var isNameViewVisible: Bool = true
  private(set) var isLoading = true
  private(set) var error: Error?
  private(set) var photoUri: String
  private let getProfileValueTalksUseCase: GetProfileValueTalksUseCase
  
  func handleAction(_ action: Action) {
    switch action {
    case let .contentOffsetDidChange(offset):
      contentOffset = offset
      isNameViewVisible = offset > Constant.nameVisibilityOffset
      
    case .didTapPhotoButton:
      isPhotoViewPresented = true
    }
  }
  
  private func fetchMatchValueTalk() async {
    do {
      let entity = try await getProfileValueTalksUseCase.execute()
      valueTalks = entity.map {
        ValueTalk(
          id: UUID(),
          topic: $0.category,
          summary: $0.summary,
          answer: $0.answer
        )
      }
      
      error = nil
    } catch {
      self.error = error
    }
    isLoading = false
  }
}
