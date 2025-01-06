//
//  MatchingMainViewModel.swift
//  MatchingMain
//
//  Created by eunseou on 1/4/25.
//

import SwiftUI
import Combine

final class MatchingMainViewModel: ObservableObject {
  struct State {
    var description: String
    var name: String
    var age: String
    var location: String
    var job: String
    var tags: [String]
  }
  
  enum Event {
    case fetchProfile
  }
  
  @Published private(set) var state: State
  private var cancellables: Set<AnyCancellable> = []
  
  init(initialState: State = State(
    description: "[나를 표현하는 한마디]",
    name: "[닉네임]",
    age: "02",
    location: "대구광역시",
    job: "학생",
    tags: [
      "바깥 데이트 스킨십도 가능",
      "함께 술을 즐기고 싶어요",
      "커밍아웃은 가까운 친구에게만 했어요",
      "연락은 바쁘더라도 자주",
      "최대 너비 260. 두 줄 노출 가능. 최대 너비 260. 두 줄 노출 가능."
    ]
  )
  ) {
    self.state = initialState
  }
  
  func send(_ event: Event) {
    switch event {
    case .fetchProfile:
      fetchProfile()
    }
  }
  
  private func fetchProfile() {
    Just(State(
      description: "[나를 표현하는 한마디]",
      name: "[닉네임]",
      age: "02",
      location: "대구광역시",
      job: "학생",
      tags: [
        "바깥 데이트 스킨십도 가능",
        "함께 술을 즐기고 싶어요",
        "커밍아웃은 가까운 친구에게만 했어요",
        "연락은 바쁘더라도 자주",
        "최대 너비 260. 두 줄 노출 가능. 최대 너비 260. 두 줄 노출 가능."
      ]
    ))
    .sink { [weak self] newState in
      self?.state = newState
    }
    .store(in: &cancellables)
  }
}
