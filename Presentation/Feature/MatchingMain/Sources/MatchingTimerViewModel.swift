//
//  MatchingTimerViewModel.swift
//  MatchingMain
//
//  Created by eunseou on 1/4/25.
//

import SwiftUI
import Observation
import PCFoundationExtension

@Observable
final class MatchingTimerViewModel {
  struct State {
    var timeRemaining: TimeInterval = 0
    var timeString: String = "00:00:00"
  }
  
  private enum Constant {
    static let targetHour: Int = 22
    static let targetMinute: Int = 0
    static let targetSecond: Int = 0
  }

  private(set) var state: State
  private var timer: Timer?

  init(initialState: State = State()) {
    self.state = initialState
    startTimer()
  }
  
  deinit {
    timer?.invalidate()
  }
  
  private func startTimer() {
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
      self?.updateRemainingTime()
    }
  }
  
  private func updateRemainingTime() {
    let now = Date()
    let targetTime = calculateTargetTime(from: now)
    
    // 현재 시간이 오늘의 목표 시간을 지났다면 다음날까지의 시간을 계산
    if now > targetTime {
      if let nextDayTargetTime = Calendar.current.date(byAdding: .day, value: 1, to: targetTime) {
        state.timeRemaining = nextDayTargetTime.timeIntervalSince(now)
      }
    } else {
      // 현재 시간이 오늘의 목표 시간 이전이라면 오늘까지의 시간을 계산
      state.timeRemaining = targetTime.timeIntervalSince(now)
    }

    state.timeString = DateFormatter.formattedTimeString(from: state.timeRemaining)
  }

  private func calculateTargetTime(from date: Date) -> Date {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone.current
    calendar.locale = Locale(identifier: "ko_KR")
    var targetDateComponents = calendar.dateComponents([.year, .month, .day], from: date)
    targetDateComponents.hour = Constant.targetHour
    targetDateComponents.minute = Constant.targetMinute
    targetDateComponents.second = Constant.targetSecond

    return calendar.date(from: targetDateComponents) ?? date
  }
}
