//
//  PostProfileRequestDTO.swift
//  DTO
//
//  Created by summercat on 2/9/25.
//

import Entities
import Foundation

public struct PostProfileRequestDTO: Encodable {
  public init(
    nickname: String,
    description: String,
    birthdate: String,
    height: Int,
    weight: Int,
    job: String,
    location: String,
    smokingStatus: String,
    snsActivityLevel: String,
    contacts: [String : String],
    imageUrl: String,
    valueTalks: [ValueTalkRequestDTO],
    valuePicks: [ValuePickRequestDTO]
  ) {
    self.nickname = nickname
    self.description = description
    self.birthdate = birthdate
    self.height = height
    self.weight = weight
    self.job = job
    self.location = location
    self.smokingStatus = smokingStatus
    self.snsActivityLevel = snsActivityLevel
    self.contacts = contacts
    self.imageUrl = imageUrl
    self.valueTalks = valueTalks
    self.valuePicks = valuePicks
  }
  
  public let nickname: String
  public let description: String
  public let birthdate: String
  public let height: Int
  public let weight: Int
  public let job: String
  public let location: String
  public let smokingStatus: String
  public let snsActivityLevel: String
  public let contacts: [String: String]
  public let imageUrl: String
  public let valueTalks: [ValueTalkRequestDTO]
  public let valuePicks: [ValuePickRequestDTO]
}

public extension ProfileModel {
  func toDto() -> PostProfileRequestDTO {
    var contactsDictionary: [String: String] = [:]
    contacts.forEach { model in
      contactsDictionary[model.type.rawValue] = model.value
    }
    
    var valueTalkDtos: [ValueTalkRequestDTO] = []
    valueTalks.forEach { model in
      valueTalkDtos.append(ValueTalkRequestDTO(valueTalkId: model.id, answer: model.answer ?? ""))
    }
    
    var valuePickDtos: [ValuePickRequestDTO] = []
    valuePicks.forEach { model in
      valuePickDtos.append(ValuePickRequestDTO(valuePickId: model.id, selectedAnswer: model.selectedAnswer ?? 0))
    }
    
    return PostProfileRequestDTO(
      nickname: nickname,
      description: description,
      birthdate: birthdate,
      height: height,
      weight: weight,
      job: job,
      location: location,
      smokingStatus: smokingStatus,
      snsActivityLevel: snsActivityLevel,
      contacts: contactsDictionary,
      imageUrl: imageUri,
      valueTalks: valueTalkDtos,
      valuePicks: valuePickDtos
    )
  }
}
