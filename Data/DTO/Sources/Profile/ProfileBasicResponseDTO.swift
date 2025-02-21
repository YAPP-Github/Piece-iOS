//
//  ProfileBasicResponseDTO.swift
//  DTO
//
//  Created by summercat on 2/22/25.
//

import Entities
import Foundation

public struct ProfileBasicResponseDTO: Decodable {
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
  public let imageUrl: String
  public let contacts: [ContactResponseDTO]
}

public extension ProfileBasicResponseDTO {
  func toDomain() -> ProfileModel {
    let dateFormatter = DateFormatter()

    return ProfileModel(
      nickname: nickname,
      description: description,
      age: age,
      birthdate: birthdate,
      height: height,
      weight: weight,
      job: job,
      location: location,
      smokingStatus: smokingStatus,
      snsActivityLevel: snsActivityLevel,
      imageUri: imageUrl,
      contacts: contacts.map { $0.toDomain() },
      valueTalks: [],
      valuePicks: []
    )
  }
}
