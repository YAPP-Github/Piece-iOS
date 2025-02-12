//
//  LoginRepositoryInterfaces.swift
//  RepositoryInterfaces
//
//  Created by eunseou on 2/8/25.
//

import SwiftUI
import Entities
import DTO

public protocol LoginRepositoryInterfaces {
  func socialLogin(providerName: SocialLoginType, token: String) async throws -> SocialLoginModel
}
