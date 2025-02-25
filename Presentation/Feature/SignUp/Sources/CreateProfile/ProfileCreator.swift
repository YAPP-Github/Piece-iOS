//
//  ProfileCreator.swift
//  SignUp
//
//  Created by summercat on 2/10/25.
//

import Entities

final class ProfileCreator {
  private(set) var isBasicInfoValid: Bool = false
  private(set) var basicInfo: ProfileBasicModel = ProfileBasicModel.empty
  private(set) var valueTalks: [ValueTalkModel] = []
  private(set) var valuePicks: [ProfileValuePickModel] = []
  private(set) var isValuePicksValid: Bool = false
  
  func updateBasicInfo(_ profile: ProfileBasicModel) {
    print(profile)
    self.basicInfo = profile
    isBasicInfoValid = true
  }
  
  func updateValueTalks(_ valueTalks: [ValueTalkModel]) {
    self.valueTalks = valueTalks
    print(valueTalks)
  }
  
  func updateValuePicks(_ valuePicks: [ProfileValuePickModel]) {
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
