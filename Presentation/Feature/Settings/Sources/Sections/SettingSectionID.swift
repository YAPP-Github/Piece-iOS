//
//  SettingSectionID.swift
//  Settings
//
//  Created by summercat on 2/12/25.
//

enum SettingSectionID {
  case loginInformation
  case notification
  case system
  case ask
  case information
  case etc
  
  var title: String {
    switch self {
    case .loginInformation:
      return "로그인 계정"
    case .notification:
      return "알림"
    case .system:
      return "시스템 설정"
    case .ask:
      return "문의"
    case .information:
      return "안내"
    case .etc:
      return "기타"
    }
  }
}
