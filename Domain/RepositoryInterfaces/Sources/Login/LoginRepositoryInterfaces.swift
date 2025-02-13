//
//  LoginRepositoryInterfaces.swift
//  RepositoryInterfaces
//
//  Created by eunseou on 2/8/25.
//

import SwiftUI
import Entities

public protocol LoginRepositoryInterfaces {
  func socialLogin(providerName: SocialLoginType, token: String) async throws -> SocialLoginResultModel
}
