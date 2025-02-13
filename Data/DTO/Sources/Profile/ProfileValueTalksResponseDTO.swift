//
//  ProfileValueTalksResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/13/25.
//

import Foundation

public struct ProfileValueTalksResponseDTO: Decodable {
  public let responses: [ProfileValueTalkResponseDTO]
}
