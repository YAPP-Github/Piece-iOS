//
//  ValueTalksResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/9/25.
//

import Entities
import Foundation

public struct ValueTalksResponseDTO: Decodable {
  public let responses: [ValueTalkResponseDTO]
  
  public init(responses: [ValueTalkResponseDTO]) {
    self.responses = responses
  }
}

public struct ValueTalkResponseDTO: Decodable {
  public let id: Int
  public let category: String
  public let title: String
  public let placeholder: String
  public let guides: [String]
  
  public init(
    id: Int,
    category: String,
    title: String,
    placeholder: String,
    guides: [String]
  ) {
    self.id = id
    self.category = category
    self.title = title
    self.placeholder = placeholder
    self.guides = guides
  }
}

public extension ValueTalkResponseDTO {
  func toDomain() -> ValueTalkModel {
    ValueTalkModel(
      id: id,
      category: category,
      title: title,
      placeholder: placeholder,
      guides: guides
    )
  }
}
