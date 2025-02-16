//
//  BlockContactsModel.swift
//  Entities
//
//  Created by eunseou on 2/16/25.
//

import SwiftUI

public struct BlockContactsModel: Decodable {
  public let phoneNumbers: [String]
  
  public init(phoneNumbers: [String]) {
    self.phoneNumbers = phoneNumbers
  }
}

