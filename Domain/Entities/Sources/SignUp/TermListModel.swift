//
//  TermListModel.swift
//  Entities
//
//  Created by eunseou on 2/2/25.
//

import Foundation

public struct TermsListModel {
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

public struct TermsItems {
  public let responses: [TermItem]
  
  public init(responses: [TermItem]) {
    self.responses = responses
  }
}

public struct TermItem {
    let termId: Int
    let title: String
    let content: String
    let required: Bool
    let startDate: Date
  
  public init(
    termId: Int,
    title: String,
    content: String,
    required: Bool,
    startDate: Date
  ) {
    self.termId = termId
    self.title = title
    self.content = content
    self.required = required
    self.startDate = startDate
  }
}
