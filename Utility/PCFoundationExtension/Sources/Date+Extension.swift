//
//  Date+Extension.swift
//  PCFoundationExtension
//
//  Created by summercat on 2/22/25.
//

import Foundation

public extension Date {
  func extractYear() -> String {
    let year = Calendar.current.component(.year, from: self)
    let lastTwoDigits = String(format: "%02d", year % 100)
    
    return lastTwoDigits
  }
}
