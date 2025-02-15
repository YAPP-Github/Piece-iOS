//
//  MatchMainRepositoryInterface.swift
//  RepositoryInterfaces
//
//  Created by eunseou on 2/15/25.
//

import SwiftUI
import Entities

public protocol MatchMainRepositoryInterface {
  func getMatchInfos() async throws -> MatchInfosModel
}
