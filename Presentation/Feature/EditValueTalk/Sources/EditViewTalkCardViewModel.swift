//
//  EditViewTalkCardViewModel.swift
//  EditValueTalk
//
//  Created by summercat on 2/9/25.
//

import Combine
import Entities
import Foundation
import SwiftUI
import Observation

@Observable
final class EditValueTalkCardViewModel: Equatable {
  static func == (lhs: EditValueTalkCardViewModel, rhs: EditValueTalkCardViewModel) -> Bool {
    lhs.model == rhs.model
  }
  
  enum Action {
    case didUpdateAnswer(String)
    case didUpdateSummary(String)
    case didTapSummaryButton
  }
  
  enum SummaryStatus {
    case plain
    case isEditing
    case isWaiting
  }
  
  var model: ProfileValueTalkModel
  let index: Int
  let isEditingAnswer: Bool
  var summaryStatus: SummaryStatus = .plain
  var localAnswer: String
  var localSummary: String
  var currentGuideText: String {
    model.guides[guideTextIndex]
  }
  private(set) var guideTextIndex: Int = 0
  private var cancellables: [AnyCancellable] = []
  
  let onModelUpdate: (ProfileValueTalkModel) -> Void
  
  init(
    model: ProfileValueTalkModel,
    index: Int,
    isEditingAnswer: Bool,
    onModelUpdate: @escaping (ProfileValueTalkModel) -> Void
  ) {
    self.model = model
    self.index = index
    self.isEditingAnswer = isEditingAnswer
    self.onModelUpdate = onModelUpdate
    self.localAnswer = model.answer
    self.localSummary = model.summary
    startTimer()
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case let .didUpdateAnswer(answer):
      let limitedText = answer.count <= 300 ? answer : String(answer.prefix(300))
      localAnswer = limitedText
      
    case let .didUpdateSummary(summary):
      let limitedText = summary.count <= 50 ? summary : String(summary.prefix(50))
      localSummary = limitedText
      
    case .didTapSummaryButton:
      didTapSummaryButton()
    }
  }

  private func increaseGuideTextIndex() {
    guideTextIndex = (guideTextIndex + 1) % model.guides.count
  }
  
  private func didTapSummaryButton() {
    switch summaryStatus {
    case .plain:
      summaryStatus = .isEditing
    case .isEditing:
      onModelUpdate(model)
      summaryStatus = .plain
    case .isWaiting:
      onModelUpdate(model)
      // TODO: - AI 요약 완료 이벤트 받으면, 클로저 호출 후 .plain 상태로
      break
    }
  }
  
  private func startTimer() {
    Timer.publish(every: 3, on: .main, in: .common).autoconnect()
      .sink { [weak self] _ in
        self?.increaseGuideTextIndex()
      }
      .store(in: &cancellables)
  }
}
