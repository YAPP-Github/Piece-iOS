//
//  SSERepository.swift
//  Repository
//
//  Created by summercat on 2/16/25.
//

import DTO
import Entities
import Foundation
import PCNetwork
import RepositoryInterfaces

public final class SSERepository: SSERepositoryInterface {
  private let sseService: SSEService
  
  public init(sseService: SSEService) {
    self.sseService = sseService
  }
  
  public func connectSse() -> AsyncThrowingStream<AISummaryModel, Error> {
    let endpoint = SSEEndpoint.connect

    return AsyncThrowingStream { continuation in
      Task {
        do {
          for try await dto in sseService.connectSSE(endpoint: endpoint) {
            let entity = AISummaryModel(profileValueTalkId: dto.profileValueTalkId, summary: dto.summary)
            continuation.yield(entity)
          }
          continuation.finish()
        } catch {
          continuation.finish(throwing: error)
        }
      }
    }
  }
  
  public func disconnectSse() async throws -> VoidModel {
    let endpoint = SSEEndpoint.disconnect
    let responseDto: VoidResponseDTO = try await sseService.disconnectSSE(endpoint: endpoint)
    
    return responseDto.toDomain()
  }
}
