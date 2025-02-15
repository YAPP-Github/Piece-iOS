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
  case AvoidContactsGuide
  case login
  case termsAgreement
  case matchProfileBasic
  case matchValueTalk
  case matchValuePick
  case signUp
  case createProfile
  case editValueTalk
  case editValuePick
  case withdraw
  case withdrawConfirm
  case settingsWebView(title: String, uri: String)
}
