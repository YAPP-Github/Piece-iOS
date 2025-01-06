//
//  MatchingTimerViewModel.swift
//  MatchingMain
//
//  Created by eunseou on 1/4/25.
//

import SwiftUI
import Combine

final class MatchingTimerViewModel: ObservableObject {
  struct State {
    var timeRemaining: TimeInterval = 0
    var timeString: String = "00:00:00"
  }
  
  @Published private(set) var state: State
  private var cancellables: Set<AnyCancellable> = []
  private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
  
  init(
    initialState: State = State()
  ) {
    self.state = initialState
    self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    startTimer()
  }
  
  private func startTimer() {
    timer
      .sink { [weak self] _ in
        self?.updateRemainingTime()
      }
      .store(in: &cancellables)
  }
  
  private func updateRemainingTime() {
    let now = Date()
    let targetTime = calculateTargetTime(from: now)
    
    if now > targetTime {
      if let nextDayTargetTime = Calendar.current.date(byAdding: .day, value: 1, to: targetTime) {
        state.timeRemaining = nextDayTargetTime.timeIntervalSince(now)
      }
    } else {
      state.timeRemaining = targetTime.timeIntervalSince(now)
    }
    
    state.timeString = DateFormatter.formattedTimeString(from: state.timeRemaining)
  }
  
  
  // 현재를 기준으로 22시로부터 남은시간 계산
  private func calculateTargetTime(from date: Date) -> Date {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone.current
    var targetDateComponents = calendar.dateComponents([.year, .month, .day], from: date)
    targetDateComponents.hour = 22
    targetDateComponents.minute = 0
    targetDateComponents.second = 0
    
    return calendar.date(from: targetDateComponents)!
  }
}
