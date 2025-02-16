//
//  ReportsRepositoryInterface.swift
//  RepositoryInterfaces
//
//  Created by summercat on 2/16/25.
//

import Entities

public protocol ReportsRepositoryInterface {
  func reportUser() async throws -> VoidModel
}
