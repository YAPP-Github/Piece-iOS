//
//  GetMatchProfileBasicUseCase.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Entities

public protocol GetMatchProfileBasicUseCase {
  func execute() async throws -> MatchProfileBasicModel
}
