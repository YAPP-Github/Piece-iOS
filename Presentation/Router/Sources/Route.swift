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
  case termsWebView(title: String, url: String)
  case checkPremission
  case completeSignUp
  case matchMain
  case matchProfileBasic
  case matchValueTalk
  case matchValuePick
  case signUp
  case verifyContact
  case createProfile
  case editValueTalk
  case editValuePick
  case withdraw
  case withdrawConfirm
  case settingsWebView(title: String, uri: String)
}
