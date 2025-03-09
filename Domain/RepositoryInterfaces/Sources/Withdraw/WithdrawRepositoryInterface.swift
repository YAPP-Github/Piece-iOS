//
//  WithdrawRepositoryInterface.swift
//  RepositoryInterfaces
//
//  Created by eunseou on 2/17/25.
//

import SwiftUI
import Entities

public protocol WithdrawRepositoryInterface {
  func deleteUserAccount(providerName: String, oauthCredential: String, reason: String) async throws -> VoidModel
}
