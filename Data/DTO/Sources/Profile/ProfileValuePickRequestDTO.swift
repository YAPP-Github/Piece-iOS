//
//  ProfileValuePickRequestDTO.swift
//  DTO
//
//  Created by summercat on 2/13/25.
//

import Foundation

public struct ProfileValuePickRequestDTO: Encodable {
  public let profileValuePickId: Int
  public let selectedAnswer: Int
  
  public init(profileValuePickId: Int, selectedAnswer: Int) {
    self.profileValuePickId = profileValuePickId
    self.selectedAnswer = selectedAnswer
  }
}
