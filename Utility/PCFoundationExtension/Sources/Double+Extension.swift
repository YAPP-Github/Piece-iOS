//
//  Double+Extension.swift
//  PCFoundationExtension
//
//  Created by 홍승완 on 6/7/25.
//

import Foundation

public extension Double {
  var formattedTime: String {
    let minutes = Int(self) / 60
    let seconds = Int(self) % 60
    return String(format: "%02d:%02d", minutes, seconds)
  }
}
