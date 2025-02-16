//
//  SSERepository.swift
//  Repository
//
//  Created by summercat on 2/16/25.
//

import DTO
import Entities
import PCNetwork
import RepositoryInterfaces

public final class SSERepository: SSERepositoryInterface {
  private let networkService: NetworkService
  
  public init(networkService: NetworkService) {
    self.networkService = networkService
  }
  
  public func connectSse() -> AsyncThrowingStream<AISummaryModel, Error> {
    let endpoint = SSEEndpoint.connect
    
    return AsyncThrowingStream { continuation in
      Task {
        do {
          for try await dto in networkService.connectSse(endpoint: endpoint) {
            let entity = AISummaryModel(profileValueTalkId: dto.profileValueTalkId, summary: dto.summary)
            continuation.yield(entity)
          }
          continuation.finish()
        } catch {
          continuation.finish(throwing: error)
        }
      }
      
      continuation.onTermination = { _ in
        Task { try? await disconnectSse() }
      }
    }
  }
  
  public func disconnectSse() async throws -> VoidModel {
    let endpoint = SSEEndpoint.disconnect
    let responseDto: VoidResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return responseDto.toDomain()
  }
}
