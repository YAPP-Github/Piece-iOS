//
//  WithdrawRepository.swift
//  Repository
//
//  Created by eunseou on 2/17/25.
//

import DTO
import Entities
import PCNetwork
import RepositoryInterfaces

final class WithdrawRepository: WithdrawRepositoryInterface {
private let networkService: NetworkService

  init(networkService: NetworkService) {
    self.networkService = networkService
  }
  
  public func deleteUserAccount(providerName: String, oauthCredential: String, reason: String) async throws -> VoidModel {
    let body = WithdrawRequestDTO(providerName: providerName, oauthCredential: oauthCredential, reason: reason)
    let endpoint = CommonEndpoint.withdrawWithPiece(body)
    let response: VoidResponseDTO = try await networkService.request(endpoint: endpoint)
    return response.toDomain()
  }
}


