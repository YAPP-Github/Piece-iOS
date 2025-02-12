//
//  ProfileCreator.swift
//  SignUp
//
//  Created by summercat on 2/10/25.
//

import Entities

final class ProfileCreator {
  private(set) var isBasicInfoValid: Bool = false
  private(set) var valueTalks: [ValueTalkModel] = []
  private(set) var valuePicks: [ValuePickModel] = []
  private(set) var isValuePicksValid: Bool = false
  private var basicInfo: ProfileModel = ProfileModel.empty
  
  func updateBasicInfo(_ profile: ProfileModel) {
    print(profile)
    self.basicInfo = profile
  }
  
  func updateValueTalks(_ valueTalks: [ValueTalkModel]) {
    self.valueTalks = valueTalks
    print(valueTalks)
  }
  
  func updateValuePicks(_ valuePicks: [ValuePickModel]) {
    print(valuePicks)
    self.valuePicks = valuePicks
    isValuePicksValid = true
  }
  
  func isProfileValid() -> Bool {
    isBasicInfoValid && isValuePicksValid
  }
  
  func createProfile() -> ProfileModel {
    return ProfileModel(
      nickname: basicInfo.nickname,
      description: basicInfo.description,
      age: basicInfo.age,
      birthdate: basicInfo.birthdate,
      height: basicInfo.height,
      weight: basicInfo.weight,
      job: basicInfo.job,
      location: basicInfo.location,
      smokingStatus: basicInfo.smokingStatus,
      snsActivityLevel: basicInfo.snsActivityLevel,
      imageUri: basicInfo.imageUri,
      contacts: basicInfo.contacts,
      valueTalks: valueTalks,
      valuePicks: valuePicks
    )
  }
}
