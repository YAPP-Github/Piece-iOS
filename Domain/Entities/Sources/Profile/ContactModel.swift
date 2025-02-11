//
//  ContactModel.swift
//  Entities
//
//  Created by summercat on 2/9/25.
//

public struct ContactModel {
  public enum ContactType: String {
    case kakao = "KAKAO_TALK_ID"
    case openKakao = "OPEN_CHAT_URL"
    case instagram = "INSTAGRAM_ID"
    case phone = "PHONE_NUMBER"
  }
  
  public let type: ContactType
  public let value: String
  
  public init(type: ContactType, value: String) {
    self.type = type
    self.value = value
  }
}
