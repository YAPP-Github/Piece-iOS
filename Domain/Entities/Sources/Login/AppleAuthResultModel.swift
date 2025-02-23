//
//  AppleLoginResultModel.swift
//  Entities
//
//  Created by eunseou on 2/23/25.
//

import SwiftUI

public struct AppleAuthResultModel {
  public let authorizationCode: String
  public let fullName: PersonNameComponents?
  public let email: String?
  
  public init(authorizationCode: String, fullName: PersonNameComponents?, email: String?) {
    self.authorizationCode = authorizationCode
    self.fullName = fullName
    self.email = email
  }
}
