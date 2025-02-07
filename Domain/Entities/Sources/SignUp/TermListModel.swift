//
//  TermListModel.swift
//  Entities
//
//  Created by eunseou on 2/2/25.
//

import Foundation

public struct TermsListModel: Decodable {
  public let status: String
  public let message: String
  public let data: TermsItems
  
  public init(
    status: String,
    message: String,
    data: TermsItems
  ) {
    self.status = status
    self.message = message
    self.data = data
  }
}

public struct TermsItems: Decodable {
  public let responses: [TermItem]
  
  public init(responses: [TermItem]) {
    self.responses = responses
  }
}

public struct TermItem: Decodable {
  public let termId: Int
  public let title: String
  public let content: String
  public let required: Bool
  public let startDate: String
  
  public init(
    termId: Int,
    title: String,
    content: String,
    required: Bool,
    startDate: String
  ) {
    self.termId = termId
    self.title = title
    self.content = content
    self.required = required
    self.startDate = startDate
  }
}
