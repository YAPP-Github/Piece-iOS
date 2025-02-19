//
//  ViewTalkCardViewModel.swift
//  SignUp
//
//  Created by summercat on 2/9/25.
//

import Combine
import Entities
import Foundation
import SwiftUI
import Observation

@Observable
final class ValueTalkCardViewModel: Hashable {
  static func == (lhs: ValueTalkCardViewModel, rhs: ValueTalkCardViewModel) -> Bool {
    lhs.model == rhs.model
  }
  
  enum Action {
    case didUpdateAnswer(String)
  }
  
  var model: ValueTalkModel
  let index: Int
  var localAnswer: String
  var currentGuideText: String {
    model.guides[guideTextIndex]
  }
  private(set) var guideTextIndex: Int = 0
  private var cancellables: [AnyCancellable] = []
  
  init(
    model: ValueTalkModel,
    index: Int
  ) {
    self.model = model
    self.index = index
    self.localAnswer = model.answer ?? ""
    startTimer()
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case let .didUpdateAnswer(answer):
      let limitedText = answer.count <= 300 ? answer : String(answer.prefix(300))
      localAnswer = limitedText
    }
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(model)
    hasher.combine(index)
    hasher.combine(localAnswer)
  }

  private func increaseGuideTextIndex() {
    guideTextIndex = (guideTextIndex + 1) % model.guides.count
  }
  
  private func startTimer() {
    Timer.publish(every: 3, on: .main, in: .common).autoconnect()
      .sink { [weak self] _ in
        self?.increaseGuideTextIndex()
      }
      .store(in: &cancellables)
  }
}
