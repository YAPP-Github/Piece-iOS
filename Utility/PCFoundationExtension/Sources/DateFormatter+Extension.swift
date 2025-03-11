//
//  DateFormatter+Extension.swift
//  MatchingMain
//
//  Created by eunseou on 1/6/25.
//

import Foundation

public extension DateFormatter {
  static func formattedTimeString(from timeInterval: TimeInterval) -> String {
    let hours = Int(timeInterval) / 3600
    let minutes = Int(timeInterval) / 60 % 60
    let seconds = Int(timeInterval) % 60
    
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
  }
}
