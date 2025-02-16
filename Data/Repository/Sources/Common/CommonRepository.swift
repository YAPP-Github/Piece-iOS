//
//  CommonRepository.swift
//  Repository
//
//  Created by summercat on 2/15/25.
//

import DTO
import Entities
import PCNetwork
import RepositoryInterfaces

public final class CommonRepository: CommonRepositoryInterface {
  private let networkService: NetworkService

  public init(networkService: NetworkService) {
    self.networkService = networkService
  }
  
  public func getServerStatus() async throws -> VoidModel {
    let endpoint = CommonEndpoint.healthCheck
    let response: VoidResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return response.toDomain()
  }
}
