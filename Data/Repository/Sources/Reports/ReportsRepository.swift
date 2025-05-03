//
//  ReportsRepository.swift
//  Repository
//
//  Created by summercat on 2/16/25.
//

import DTO
import Entities
import PCNetwork
import RepositoryInterfaces

final class ReportsRepository: ReportsRepositoryInterface {
  private let networkService: NetworkService
  
  init(networkService: NetworkService) {
    self.networkService = networkService
  }
  
  func reportUser(
    id: Int,
    reason: String
  ) async throws -> VoidModel {
    let requestDto = ReportsRequestDTO(
      reportedUserId: id,
      reason: reason
    )
    let endpoint = ReportsEndpoint.report(requestDto)
    let response: VoidResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return response.toDomain()
  }
}
