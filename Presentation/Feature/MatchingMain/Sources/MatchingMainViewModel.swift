//
//  MatchingMainViewModel.swift
//  MatchingMain
//
//  Created by eunseou on 1/4/25.
//

import SwiftUI
import Observation

@Observable
final class MatchingMainViewModel {
  enum Action {
    case tapProfileInfo
    case acceptMatching
  }
  
  private(set) var description: String
  private(set) var name: String
  private(set) var age: String
  private(set) var location: String
  private(set) var job: String
  private(set) var tags: [String]
  var buttonTitle: String
  var matchingStatus: MatchingAnswer.MatchingStatus
  
  init(
    description: String,
    name: String,
    age: String,
    location: String,
    job: String,
    tags: [String],
    buttonTitle: String,
    matchingStatus: MatchingAnswer.MatchingStatus
  ) {
    self.description = description
    self.name = name
    self.age = age
    self.location = location
    self.job = job
    self.tags = tags
    self.buttonTitle = buttonTitle
    self.matchingStatus = matchingStatus
  }
  
  func handleAction(_ action: Action) {
    switch action {
    default: return
    }
  }
}
