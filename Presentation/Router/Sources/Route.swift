//
//  Route.swift
//  Router
//
//  Created by summercat on 1/30/25.
//

public enum Route: Hashable {
  case home
  case AvoidContactsGuide
  case login
  case termsAgreement
  case matchProfileBasic
  case matchValueTalk
  case matchValuePick
  case signUp
  case createProfile
  case editValuePick
  case settingsWebView(title: String, uri: String)
}
