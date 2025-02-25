//
//  String+Extension.swift
//  PCFoundationExtension
//
//  Created by summercat on 2/26/25.
//

import Foundation

public extension String {
  func extractYear() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: self) ?? Date()
    let year = Calendar.current.component(.year, from: date)
    let lastTwoDigits = String(format: "%02d", year % 100)
    
    return lastTwoDigits
  }
}
