//
//  ProfileValuePicksRequestDTO.swift
//  DTO
//
//  Created by summercat on 2/13/25.
//

import Foundation

public struct ProfileValuePicksRequestDTO: Encodable {
  public let profileValuePickUpdateRequests: [ProfileValuePickRequestDTO]
  
  public init(profileValuePickUpdateRequests: [ProfileValuePickRequestDTO]) {
    self.profileValuePickUpdateRequests = profileValuePickUpdateRequests
  }
}
