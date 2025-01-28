//
//  GetMatchValueTalkUseCase.swift
//  UseCases
//
//  Created by summercat on 1/28/25.
//

import Entities

public protocol GetMatchValueTalkUseCase {
  func execute() async throws -> MatchValueTalkModel
}
