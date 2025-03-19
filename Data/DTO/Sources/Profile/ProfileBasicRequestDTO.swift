//
//  ProfileBasicRequestDTO.swift
//  DTO
//
//  Created by eunseou on 3/18/25.
//

import SwiftUI
import Entities
import Foundation

public struct ProfileBasicRequestDTO: Encodable {
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
  public let contacts: [String : String]
  
  public init(nickname: String, description: String, age: Int, birthdate: String, height: Int, weight: Int, job: String, location: String, smokingStatus: String, snsActivityLevel: String, imageUrl: String, contacts: [String : String]) {
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
    self.contacts = contacts
  }
}

public extension ProfileBasicModel{
  func toDTO() -> ProfileBasicRequestDTO {
    let contactsDict = contacts.reduce(into: [String: String]()) { dict, contact in
      dict[contact.type.rawValue] = contact.value
    }
    
    return ProfileBasicRequestDTO(
      nickname: nickname,
      description: description,
      age: age ?? 0,
      birthdate: birthdate,
      height: height,
      weight: weight,
      job: job,
      location: location,
      smokingStatus: smokingStatus,
      snsActivityLevel: snsActivityLevel,
      imageUrl: imageUri,
      contacts: contactsDict
    )
  }
}

