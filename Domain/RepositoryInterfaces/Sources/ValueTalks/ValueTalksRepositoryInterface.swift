//
//  ValueTalksRepositoryInterface.swift
//  RepositoryInterfaces
//
//  Created by summercat on 2/9/25.
//

import Entities

public protocol ValueTalksRepositoryInterface {
  func getValueTalks() async throws -> [ValueTalkModel]
}
