//
//  ContactModel.swift
//  Entities
//
//  Created by summercat on 2/9/25.
//

import Foundation

public struct ContactModel: Hashable, Identifiable {
  public enum ContactType: String {
    case kakao = "KAKAO_TALK_ID"
    case openKakao = "OPEN_CHAT_URL"
    case instagram = "INSTAGRAM_ID"
    case phone = "PHONE_NUMBER"
    case unknown = "UNKNOWN"
  }
  
  public let id = UUID()
  public var type: ContactType
  public var value: String
  
  public init(type: ContactType, value: String) {
    self.type = type
    self.value = value
  }
}
public extension ContactModel.ContactType {
  static func from(iconName: String) -> ContactModel.ContactType {
    switch iconName {
    case "kakao-32": return .kakao
    case "kakao-openchat-32": return .openKakao
    case "instagram-32": return .instagram
    case "cell-fill-32": return .phone
    default: return .unknown
    }
  }
}
