//
//  CheckNicknameRepository.swift
//  Repository
//
//  Created by eunseou on 2/12/25.
//

import SwiftUI
import PCNetwork
import Entities
import RepositoryInterfaces

public final class CheckNicknameRepository: CheckNinknameRepositoryInterface {
  
  private let networkService: NetworkService
  
  public init (networkService: NetworkService) {
    self.networkService = networkService
  }
  
  public func checkNickname(nickname: String) async throws -> Bool {
    let endpoint = ProfileEndpoint.postCheckNickname(nickname)
    return try await networkService.request(endpoint: endpoint)
  }
}
