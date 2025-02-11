//
//  ValuePicksResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/10/25.
//

import Entities
import Foundation

public struct ValuePicksResponseDTO: Decodable {
  public let responses: [ValuePickResponseDTO]
  
  public init(responses: [ValuePickResponseDTO]) {
    self.responses = responses
  }
}

public struct ValuePickResponseDTO: Decodable {
  public let id: Int
  public let category: String
  public let question: String
  public let answers: [ValuePickAnswerResponseDTO]
  
  public init(
    id: Int,
    category: String,
    question: String,
    answers: [ValuePickAnswerResponseDTO]
  ) {
    self.id = id
    self.category = category
    self.question = question
    self.answers = answers
  }
}

public extension ValuePickResponseDTO {
  func toDomain() -> ValuePickModel {
    return ValuePickModel(
      id: id,
      category: category,
      question: question,
      answers: answers.map {
        ValuePickAnswerModel(number: $0.number, content: $0.content)
      }
    )
  }
}

public struct ValuePickAnswerResponseDTO: Decodable {
  public let number: Int
  public let content: String
  
  public init(number: Int, content: String) {
    self.number = number
    self.content = content
  }
}
