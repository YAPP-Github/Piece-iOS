//
//  DateFormatter+Extension.swift
//  MatchingMain
//
//  Created by eunseou on 1/6/25.
//

import Foundation

public extension DateFormatter {
  static func formattedTimeString(from timeInterval: TimeInterval) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    formatter.locale = Locale.current
    formatter.timeZone = TimeZone.current
    let date = Date(timeIntervalSince1970: timeInterval)
    return formatter.string(from: date)
  }
}
