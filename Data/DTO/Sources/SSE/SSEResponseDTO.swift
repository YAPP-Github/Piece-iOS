//
//  SSEResponseDTO.swift
//  DTO
//
//  Created by summercat on 3/25/25.
//

import Foundation

public struct SSEResponseDTO: Decodable {
  public let id: String
  public let event: String
  public let data: String
}
