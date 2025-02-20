//
//  MatchContactsModel.swift
//  Entities
//
//  Created by summercat on 2/20/25.
//

public struct MatchContactsModel {
  public let contacts: [ContactModel]
  
  public init(contacts: [ContactModel]) {
    self.contacts = contacts
  }
}
