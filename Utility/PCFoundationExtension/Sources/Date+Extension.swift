//
//  Date+Extension.swift
//  PCFoundationExtension
//
//  Created by summercat on 2/16/25.
//

import Foundation

extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
}
