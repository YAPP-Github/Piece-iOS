//
//  ProfileValuePicksResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/12/25.
//

import Entities
import Foundation

public struct ProfileValuePicksResponseDTO: Decodable {
  public let responses: [ProfileValuePickResponseDTO]
}
