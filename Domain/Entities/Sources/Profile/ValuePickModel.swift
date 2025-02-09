//
//  ValuePickModel.swift
//  Entities
//
//  Created by summercat on 1/30/25.
//

public struct ValuePickModel {
  public init(
    profileValuePickId: Int,
    category: String,
    question: String,
    answers: [ValuePickAnswerModel],
    selectedAnswer: Int
  ) {
    self.profileValuePickId = profileValuePickId
    self.category = category
    self.question = question
    self.answers = answers
    self.selectedAnswer = selectedAnswer
  }
  
  public let profileValuePickId: Int
  public let category: String
  public let question: String
  public let answers: [ValuePickAnswerModel]
  public let selectedAnswer: Int
}
