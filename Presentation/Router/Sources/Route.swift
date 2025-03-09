//
//  Route.swift
//  Router
//
//  Created by summercat on 1/30/25.
//

import Entities

// TODO: - 화면별로 분리해서 주석
public enum Route: Hashable {
  case splash
  case home
  case onboarding
  case AvoidContactsGuide
  case login
  case termsAgreement
  case termsWebView(title: String, url: String)
  case checkPremission
  case completeSignUp
  case matchMain
  case matchProfileBasic
  case matchValueTalk
  case matchValuePick
  case verifyContact
  case editValueTalk
  case editValuePick
  case settingsWebView(title: String, uri: String)
  case reportUser(nickname: String)
  case blockUser(matchId: Int, nickname: String)
  case matchResult(nickname: String)
  
  // MARK: - 프로필 생성
  case createProfile
  case waitingAISummary(profile: ProfileModel)
  case completeCreateProfile
  
  // MARK: - 프로필 미리보기
  case previewProfileBasic
  case previewProfileValueTalks(nickname: String, description: String, imageUri: String)
  case previewProfileValuePicks(nickname: String, description: String, imageUri: String)
  
  // MARK: - 탈퇴하기
  case withdraw
  case withdrawConfirm(reason: String)
}
