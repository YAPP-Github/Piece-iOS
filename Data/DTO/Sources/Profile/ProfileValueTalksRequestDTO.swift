//
//  ProfileValueTalksRequestDTO.swift
//  DTO
//
//  Created by summercat on 2/13/25.
//

import Foundation

public struct ProfileValueTalksRequestDTO: Encodable {
  public let profileValueTalkUpdateRequests: [ProfileValueTalkRequestDTO]
  
  public init(profileValueTalkUpdateRequests: [ProfileValueTalkRequestDTO]) {
    self.profileValueTalkUpdateRequests = profileValueTalkUpdateRequests
  }
}
