//
//  TermListResponseDTO.swift
//  DTO
//
//  Created by eunseou on 2/5/25.
//

import Foundation
import Entities

public struct TermsListResponseDTO: Decodable {
  public let status: String
  public let message: String
  public let data: TermsItemsResponseDTO
}

public struct TermsItemsResponseDTO: Decodable {
  public let responses: [TermItemResponseDTO]
}

public struct TermItemResponseDTO: Decodable {
  public let termId: Int
  public let title: String
  public let content: String
  public let required: Bool
  public let startDate: Date
}

extension TermsListResponseDTO {
  func toDomain() -> TermsListModel {
    return TermsListModel(
      status: status,
      message: message,
      data: data.toDomain()
    )
  }
}

extension TermsItemsResponseDTO {
  func toDomain() -> TermsItems {
    return TermsItems(
      responses: responses.map { $0.toDomain()})
  }
}

extension TermItemResponseDTO {
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
