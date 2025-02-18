//
//  SettingsRepository.swift
//  Repository
//
//  Created by summercat on 2/19/25.
//

import DTO
import Entities
import PCNetwork
import RepositoryInterfaces

final class SettingsRepository: SettingsRepositoryInterface {
  private let networkService: NetworkService

  init(networkService: NetworkService) {
    self.networkService = networkService
  }
  
  func getContactsSyncTime() async throws -> ContactsSyncTimeModel {
    let endpoint = SettingsEndpoint.fetchBlockContactsSyncTime
    let response: ContactsSyncTimeResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return response.toDomain()
  }
}

