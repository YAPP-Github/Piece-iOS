//
//  MatchValuePickItemModel.swift
//  Entities
//
//  Created by summercat on 2/9/25.
//

public struct MatchValuePickItemModel: Identifiable {
  public var id: String { question }
  public let category: String
  public let question: String
  public let isSameWithMe: Bool
  public let answers: [ValuePickAnswerModel]
  public let selectedAnswer: Int
  
  public init(
    category: String,
    question: String,
    sameWithMe: Bool,
    answers: [ValuePickAnswerModel],
    selectedAnswer: Int
  ) {
    self.category = category
    self.question = question
    self.isSameWithMe = sameWithMe
    self.answers = answers
    self.selectedAnswer = selectedAnswer
  }
}
