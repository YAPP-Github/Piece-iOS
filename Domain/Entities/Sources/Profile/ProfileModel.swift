//
//  ProfileModel.swift
//  Entities
//
//  Created by summercat on 1/30/25.
//

import Foundation

public struct ProfileModel: Hashable {
  public init(
    nickname: String,
    description: String,
    age: Int,
    birthdate: Date,
    height: Int,
    weight: Int,
    job: String,
    location: String,
    smokingStatus: String,
    snsActivityLevel: String,
    imageUri: String,
    contacts: [ContactModel],
    valueTalks: [ValueTalkModel],
    valuePicks: [ProfileValuePickModel]
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
    self.imageUri = imageUri
    self.contacts = contacts
    self.valueTalks = valueTalks
    self.valuePicks = valuePicks
  }
  
  public let nickname: String
  public let description: String
  public let age: Int
  public let birthdate: Date
  public let height: Int
  public let weight: Int
  public let job: String
  public let location: String
  public let smokingStatus: String
  public let snsActivityLevel: String
  public let imageUri: String
  public let contacts: [ContactModel]
  public let valueTalks: [ValueTalkModel]
  public let valuePicks: [ProfileValuePickModel]
}

public extension ProfileModel {
  static let empty = ProfileModel(
    nickname: "",
    description: "",
    age: 0,
    birthdate: Date(),
    height: 0,
    weight: 0,
    job: "",
    location: "",
    smokingStatus: "",
    snsActivityLevel: "",
    imageUri: "",
    contacts: [],
    valueTalks: [],
    valuePicks: []
  )
}
