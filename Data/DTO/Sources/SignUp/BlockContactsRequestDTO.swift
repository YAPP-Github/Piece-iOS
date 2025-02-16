//
//  BlockContactsRequestDTO.swift
//  DTO
//
//  Created by eunseou on 2/16/25.
//

import SwiftUI
import Entities

public struct BlockContactsRequestDTO: Encodable {
  public let phoneNumbers: [String]
  
  public init(phoneNumbers: [String]) {
    self.phoneNumbers = phoneNumbers
  }
}

public extension BlockContactsModel {
  func toDTO() -> BlockContactsRequestDTO {
    return BlockContactsRequestDTO(phoneNumbers: phoneNumbers)
  }
}
