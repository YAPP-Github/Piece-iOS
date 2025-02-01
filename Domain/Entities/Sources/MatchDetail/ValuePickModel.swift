//
//  ValuePickModel.swift
//  Entities
//
//  Created by summercat on 1/30/25.
//

public struct ValuePickModel {
  public init(
    category: String,
    question: String,
    sameWithMe: Bool
  ) {
    self.category = category
    self.question = question
    self.sameWithMe = sameWithMe
  }
  
  public let category: String
  public let question: String
  public let sameWithMe: Bool
}
