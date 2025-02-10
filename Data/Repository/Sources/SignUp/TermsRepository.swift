//
//  TermsRepository.swift
//  Repository
//
//  Created by eunseou on 2/5/25.
//

import Foundation
import DTO
import PCNetwork
import Entities
import RepositoryInterfaces

public final class TermsRepository: TermsRepositoryInterfaces {
  
  private let networkService: NetworkService
  
  public init (networkService: NetworkService = NetworkService()) {
    self.networkService = networkService
  }
  
  public func fetchTermList() async throws -> TermsListModel {
    let endpoint = TermsEndpoint.fetchTermList
    
    let responseDTO: TermsListResponseDTO = try await networkService.request(endpoint: endpoint)
    return responseDTO.toDomain()
  }
}
