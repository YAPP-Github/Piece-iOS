//
//  ValuePickRequestDTO.swift
//  DTO
//
//  Created by summercat on 2/9/25.
//

import Foundation

public struct ValuePickRequestDTO: Encodable {
  let valuePickId: Int
  let selectedAnswer: Int
}
