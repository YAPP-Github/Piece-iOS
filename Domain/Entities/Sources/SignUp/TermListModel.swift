//
//  TermListModel.swift
//  Entities
//
//  Created by eunseou on 2/2/25.
//

import Foundation

public struct TermsListModel: Decodable {
  public let responses: [TermItemModel]
  
  public init(responses: [TermItemModel]) {
    self.responses = responses
  }
}

public struct TermItemModel: Decodable {
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
