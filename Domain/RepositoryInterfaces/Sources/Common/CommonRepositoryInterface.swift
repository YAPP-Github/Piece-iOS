//
//  CommonRepositoryInterface.swift
//  RepositoryInterfaces
//
//  Created by summercat on 2/15/25.
//

import Entities

public protocol CommonRepositoryInterface {
  func getServerStatus() async throws -> VoidModel
}
