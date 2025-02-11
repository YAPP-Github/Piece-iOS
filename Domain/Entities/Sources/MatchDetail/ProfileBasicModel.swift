//
//  MatchProfileBasicModel.swift
//  Entities
//
//  Created by summercat on 1/30/25.
//

public struct MatchProfileBasicModel: Identifiable {
  public init(
    id: Int,
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
    self.id = id
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
  
  public let id: Int
  public let description: String
  public let nickname: String
  public let age: Int
  public let birthYear: String
  public let height: Int
  public let weight: Int
  public let location: String
  public let job: String
  public let smokingStatus: String
}
