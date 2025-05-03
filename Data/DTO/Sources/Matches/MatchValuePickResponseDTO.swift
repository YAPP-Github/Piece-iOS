//
//  MatchValuePickResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/11/25.
//

import Entities
import Foundation

public struct MatchValuePickResponseDTO: Decodable {
  public let category: String
  public let question: String
  public let isSameWithMe: Bool
  public let answers: [ValuePickAnswerResponseDTO]
  public let selectedAnswer: Int
}

public extension MatchValuePickResponseDTO {
  func toDomain() -> MatchValuePickItemModel {
    MatchValuePickItemModel(
      category: category,
      question: question,
      sameWithMe: isSameWithMe,
      answers: answers.map { ValuePickAnswerModel(number: $0.number, content: $0.content) },
      selectedAnswer: selectedAnswer
    )
  }
}
