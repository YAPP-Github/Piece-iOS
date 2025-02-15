//
//  SettingsRepositoryInterface.swift
//  RepositoryInterfaces
//
//  Created by summercat on 2/16/25.
//

import Entities

public protocol SettingsRepositoryInterface {
  func getBlockContactsSyncTime() async throws -> BlockContactsSyncTimeModel
}
