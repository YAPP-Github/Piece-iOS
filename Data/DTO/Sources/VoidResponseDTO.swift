//
//  VoidResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/12/25.
//

import Entities
import Foundation

public struct VoidResponseDTO: Decodable { }

public extension VoidResponseDTO {
  func toDomain() -> VoidModel {
    VoidModel()
  }
}
