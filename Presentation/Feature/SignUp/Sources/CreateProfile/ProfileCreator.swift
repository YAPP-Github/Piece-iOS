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
    ProfileModel(
      nickname: "애플",
      description: "iOS 테스트",
      age: 100,
      birthdate: "2000-10-01",
      height: 180,
      weight: 70,
      job: "개발자",
      location: "서울",
      smokingStatus: "흡연",
      snsActivityLevel: "활동",
      imageUri: "",
      contacts: [],
      valueTalks: valueTalks,
      valuePicks: valuePicks
    )
  }
}
