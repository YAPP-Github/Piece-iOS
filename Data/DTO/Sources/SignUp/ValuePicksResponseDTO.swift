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
