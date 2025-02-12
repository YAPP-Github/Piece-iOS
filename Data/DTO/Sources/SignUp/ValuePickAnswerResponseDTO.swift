//
//  ValuePickAnswerResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/12/25.
//

import Entities
import Foundation

public struct ValuePickAnswerResponseDTO: Decodable {
  public let number: Int
  public let content: String
  
  public init(number: Int, content: String) {
    self.number = number
    self.content = content
  }
}
