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
  
  public func deleteUserAccount(reason: String) async throws -> VoidModel {
    let body = WithdrawRequestDTO(reason: reason)
    let endpoint = UserEndpoint.withdrawWithPiece(body)
    let response: VoidResponseDTO = try await networkService.request(endpoint: endpoint)
    return response.toDomain()
  }
  public func withdrawWithApple() async throws -> VoidModel {
    
    // TODO: - 애플 전용 탈퇴 (미완)
    /// 추후 서버와 맞춰볼 필요있음.
    let body = WithdrawRequestDTO(reason: "")
    let endpoint = UserEndpoint.withdrawWithPiece(body)
    let response: VoidResponseDTO = try await networkService.request(endpoint: endpoint)
    return response.toDomain()
  }
}


