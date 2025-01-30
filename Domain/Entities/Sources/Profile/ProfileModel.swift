//
//  ProfileModel.swift
//  Entities
//
//  Created by summercat on 1/30/25.
//

public struct ProfileModel {
  public init(
    nickname: String,
    description: String,
    age: Int,
    birthdate: String,
    height: Int,
    weight: Int,
    job: String,
    location: String,
    smokingStatus: String,
    snsActivityLevel: String,
    imageUrl: String
  ) {
    self.nickname = nickname
    self.description = description
    self.age = age
    self.birthdate = birthdate
    self.height = height
    self.weight = weight
    self.job = job
    self.location = location
    self.smokingStatus = smokingStatus
    self.snsActivityLevel = snsActivityLevel
    self.imageUrl = imageUrl
  }
  
  public let nickname: String
  public let description: String
  public let age: Int
  public let birthdate: String
  public let height: Int
  public let weight: Int
  public let job: String
  public let location: String
  public let smokingStatus: String
  public let snsActivityLevel: String
  public let imageUrl: String
//  public let contacts // TODO: - 스키마 이름이 안 정해진 것 같음...
}
