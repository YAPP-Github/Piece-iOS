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
  case login
  
  // MARK: - 회원가입
  case verifyContact
  case AvoidContactsGuide
  case termsAgreement
  case termsWebView(term: TermModel)
  case checkPremission
  case completeSignUp
  
  // MARK: - 매칭
  case matchMain
  case matchProfileBasic
  case matchValueTalk
  case matchValuePick
  case editValueTalk
  case editValuePick
  case matchResult(nickname: String)
  
  // MARK: - 설정
  case settingsWebView(title: String, uri: String)
  case editProfile
  
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
  
  // MARK: - 알림
  case notificationList
  
  // MARK: - 기타
  case reportUser(nickname: String)
  case blockUser(matchId: Int, nickname: String)
}
