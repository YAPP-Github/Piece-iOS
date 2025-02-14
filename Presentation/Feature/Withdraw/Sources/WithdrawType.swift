//
//  WithdrawType.swift
//  Withdraw
//
//  Created by 김도형 on 2/13/25.
//

import Foundation

enum WithdrawType: String, CaseIterable {
    case 애인이_생겼어요 = "애인이 생겼어요"
    case 잠깐_쉬고_싶어요 = "잠깐 쉬고 싶어요"
    case 매칭이_안_이루어져요 = "매칭이 안 이루어져요"
    case 어플_사용성이_별로예요 = "어플 사용성이 별로예요"
    case 기타 = "기타"
}
