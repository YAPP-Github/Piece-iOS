//
//  ValuePickViewModel.swift
//  PreviewProfile
//
//  Created by summercat on 1/13/25.
//

import Entities
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
    case didTapPhotoButton
  }
  
  init(
    nickname: String,
    description: String,
    imageUri: String,
    getProfileValuePicksUseCase: GetProfileValuePicksUseCase
  ) {
    self.nickname = nickname
    self.description = description
    self.photoUri = imageUri
    self.getProfileValuePicksUseCase = getProfileValuePicksUseCase
    
    Task {
      await fetchMatchValueTalk()
    }
  }
  
  let navigationTitle: String = Constant.navigationTitle
  let nickname: String
  let description: String
  var isPhotoViewPresented: Bool = false
  
  private(set) var valuePicks: [ProfileValuePickModel] = []
  private(set) var isLoading = true
  private(set) var error: Error?
  private(set) var contentOffset: CGFloat = 0
  private(set) var isNameViewVisible: Bool = true
  private(set) var photoUri: String
  private let getProfileValuePicksUseCase: GetProfileValuePicksUseCase
  
  func handleAction(_ action: Action) {
    switch action {
    case let .contentOffsetDidChange(offset):
      contentOffset = offset
      isNameViewVisible = offset > Constant.nameVisibilityOffset
      
    case .didTapPhotoButton:
      isPhotoViewPresented = true
    }
  }
  
  func fetchMatchValueTalk() async {
    do {
      let entity = try await getProfileValuePicksUseCase.execute()
      valuePicks = entity
      
      error = nil
    } catch {
      self.error = error
    }
    
    isLoading = false
  }
}
