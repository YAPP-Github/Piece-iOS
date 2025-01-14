//
//  File.swift
//  PCFoundationExtension
//
//  Created by eunseou on 1/13/25.
//

import Foundation

public extension Int {
    var formattedTime: String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
