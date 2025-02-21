//
//  Route.swift
//  Router
//
//  Created by summercat on 1/30/25.
//

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
  case signUp
  case verifyContact
  case editValueTalk
  case editValuePick
  case withdraw
  case withdrawConfirm
  case settingsWebView(title: String, uri: String)
  case reportUser(nickname: String)
  case blockUser(matchId: Int, nickname: String)
  case matchResult(nickname: String)
  
  // MARK: - 프로필 생성
  case createProfile
  case waitingAISummary
  case completeCreateProfile
}
