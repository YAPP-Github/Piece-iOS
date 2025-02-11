//
//  ValuePicksRepositoryInterface.swift
//  RepositoryInterfaces
//
//  Created by summercat on 2/10/25.
//

import Entities

public protocol ValuePicksRepositoryInterface {
  func getValuePicks() async throws -> [ValuePickModel]
}
