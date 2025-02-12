//
//  ValuePickRequestDTO.swift
//  DTO
//
//  Created by summercat on 2/9/25.
//

import Foundation

public struct ValuePickRequestDTO: Encodable {
  public let valuePickId: Int
  public let selectedAnswer: Int
  
  public init(valuePickId: Int, selectedAnswer: Int) {
    self.valuePickId = valuePickId
    self.selectedAnswer = selectedAnswer
  }
}
