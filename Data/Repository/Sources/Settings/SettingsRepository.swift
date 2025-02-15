//
//  SettingsRepository.swift
//  Repository
//
//  Created by summercat on 2/16/25.
//

import DTO
import Entities
import PCNetwork
import RepositoryInterfaces

public final class SettingsRepository: SettingsRepositoryInterface {
  private let networkService: NetworkService

  public init(networkService: NetworkService) {
    self.networkService = networkService
  }
  
  public func getBlockContactsSyncTime() async throws -> Entities.BlockContactsSyncTimeModel {
    let endpoint = SettingsEndpoint.blockContactsSyncTime
    let responseDto: BlockContactsSyncTimeResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return responseDto.toDomain()
  }
}

