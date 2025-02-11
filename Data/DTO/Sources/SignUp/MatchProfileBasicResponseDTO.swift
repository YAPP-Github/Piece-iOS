//
//  MatchProfileBasicResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/11/25.
//

import Foundation

public struct MatchProfileBasicResponseDTO: Decodable {
  public let matchId: Int
  public let description: String
  public let nickname: String
  public let age: Int
  public let birthYear: String
  public let height: Int
  public let weight: Int
  public let location: String
  public let job: String
  public let smokingStatus: String
  
  public init(
    matchId: Int,
    description: String,
    nickname: String,
    age: Int,
    birthYear: String,
    height: Int,
    weight: Int,
    location: String,
    job: String,
    smokingStatus: String
  ) {
    self.matchId = matchId
    self.description = description
    self.nickname = nickname
    self.age = age
    self.birthYear = birthYear
    self.height = height
    self.weight = weight
    self.location = location
    self.job = job
    self.smokingStatus = smokingStatus
  }
}
