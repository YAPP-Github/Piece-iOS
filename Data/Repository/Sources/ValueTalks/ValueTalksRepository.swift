//
//  ValueTalksRepository.swift
//  Repository
//
//  Created by summercat on 2/9/25.
//

import DTO
import Entities
import Foundation
import PCNetwork
import RepositoryInterfaces

final class ValueTalksRepository: ValueTalksRepositoryInterface {
  private let networkService: NetworkService
  
  public init (networkService: NetworkService = NetworkService()) {
    self.networkService = networkService
  }
  
  
  func getValueTalks() async throws -> [Entities.ValueTalkModel] {
    let endpoint = ValueTalksEndpoint.getValueTalks
    let response: ValueTalksResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return response.responses.map { $0.toDomain() }
  }
}
