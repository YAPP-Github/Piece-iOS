//
//  CheckNinknameRepositoryInterface.swift
//  RepositoryInterfaces
//
//  Created by eunseou on 2/12/25.
//

import SwiftUI

public protocol CheckNinknameRepositoryInterface {
  func checkNickname(nickname: String) async throws -> Bool
}
