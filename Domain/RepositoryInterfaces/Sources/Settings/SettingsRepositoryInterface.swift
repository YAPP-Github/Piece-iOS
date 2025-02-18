//
//  SettingsRepositoryInterface.swift
//  RepositoryInterfaces
//
//  Created by summercat on 2/19/25.
//

import Entities

public protocol SettingsRepositoryInterface {
  func getContactsSyncTime() async throws -> ContactsSyncTimeModel
}
