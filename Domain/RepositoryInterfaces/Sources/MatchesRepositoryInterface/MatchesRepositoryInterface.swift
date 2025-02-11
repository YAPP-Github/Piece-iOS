//
//  MatchesRepositoryInterface.swift
//  RepositoryInterfaces
//
//  Created by summercat on 2/11/25.
//

import Entities

public protocol MatchesRepositoryInterface {
  func getMatchesProfileBasic() async throws -> MatchProfileBasicModel
  func getMatchValueTalks() async throws -> MatchValueTalkModel
  func getMatchValuePicks() async throws -> MatchValuePickModel
}
