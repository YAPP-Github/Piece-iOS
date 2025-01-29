//
//  MatchProfileBasicModel.swift
//  Entities
//
//  Created by summercat on 1/30/25.
//

public struct MatchProfileBasicModel: Identifiable {
  public let id: Int
  public let shortIntroduction: String
  public let nickname: String
  public let age: Int
  public let birthYear: String
  public let height: Int
  public let weight: Int
  public let location: String
  public let job: String
  public let smokingStatus: String
}
