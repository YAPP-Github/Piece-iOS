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

// MARK: - decodeJWT

public extension String {
    func decodeJWT() -> [String: Any]? {
        let segments = self.components(separatedBy: ".")
        guard segments.count > 1 else { return nil }
        
        var base64 = segments[1]
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        // Add padding if needed
        while base64.count % 4 != 0 {
            base64 += "="
        }
        
        guard let data = Data(base64Encoded: base64) else { return nil }
        
        return try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }
}
