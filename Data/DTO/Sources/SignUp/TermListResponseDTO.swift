//
//  TermListResponseDTO.swift
//  DTO
//
//  Created by eunseou on 2/5/25.
//

import Foundation
import Entities

public struct TermsListResponseDTO: Codable {
  public let responses: [TermItemResponseDTO]
}

public struct TermItemResponseDTO: Codable {
  public let termId: Int
  public let title: String
  public let content: String
  public let required: Bool
  public let startDate: String
}

public extension TermsListResponseDTO {
  func toDomain() -> TermsListModel {
    return TermsListModel(
      responses: responses.map { $0.toDomain()})
  }
}

public extension TermItemResponseDTO {
  func toDomain() -> TermItem {
    return TermItem(
      termId: termId,
      title: title,
      content: content,
      required: required,
      startDate: startDate
    )
  }
}
