//
//  ValuePicksRepository.swift
//  Repository
//
//  Created by summercat on 2/10/25.
//

import DTO
import Entities
import Foundation
import PCNetwork
import RepositoryInterfaces

final class ValuePicksRepository: ValuePicksRepositoryInterface {
  private let networkService: NetworkService
  
  public init (networkService: NetworkService = NetworkService()) {
    self.networkService = networkService
  }
  
  
  func getValuePicks() async throws -> [ValuePickModel] {
    let endpoint = ValuePicksEndpoint.getValuePicks
    let response: ValuePicksResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return response.responses.map { $0.toDomain() }
  }
}
