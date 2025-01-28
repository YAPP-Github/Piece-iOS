//
//  MatchProfileBasicModel.swift
//  Entities
//
//  Created by summercat on 1/28/25.
//

public struct MatchProfileBasicModel: Identifiable {
  public init(
    id: Int,
    shortIntroduce: String,
    nickname: String,
    age: Int,
    birthYear: String,
    height: Int,
    weight: Int,
    region: String,
    job: String,
    isSmoker: Bool
  ) {
    self.id = id
    self.shortIntroduce = shortIntroduce
    self.nickname = nickname
    self.age = age
    self.birthYear = birthYear
    self.height = height
    self.weight = weight
    self.region = region
    self.job = job
    self.isSmoker = isSmoker
  }
  
  public let id: Int
  public let shortIntroduce: String
  public let nickname: String
  public let age: Int
  public let birthYear: String
  public let height: Int
  public let weight: Int
  public let region: String
  public let job: String
  public let isSmoker: Bool
}
