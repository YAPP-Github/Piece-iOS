//
//  MatchesRepository.swift
//  Repository
//
//  Created by summercat on 2/11/25.
//

import RepositoryInterfaces

import DTO
import Entities
import Foundation
import PCNetwork
import RepositoryInterfaces

final class MatchesRepository: MatchesRepositoryInterface {
  private let networkService: NetworkService
  
  public init (networkService: NetworkService) {
    self.networkService = networkService
  }
  
  func getMatchesProfileBasic() async throws -> Entities.MatchProfileBasicModel {
    let endpoint = MatchesEndpoint.profileBasic
    let responseDTO: MatchProfileBasicResponseDTO = try await networkService.request(endpoint: endpoint)
    return responseDTO.toDomain()
  }
  
  func getMatchValueTalks() async throws -> MatchValueTalkModel {
    let endpoint = MatchesEndpoint.valueTalks
    let responseDTO: MatchValueTalksResponseDTO = try await networkService.request(endpoint: endpoint)
    return responseDTO.toDomain()
  }
  
  func getMatchValuePicks() async throws -> MatchValuePickModel {
    let endpoint = MatchesEndpoint.valuePicks
    let responseDTO: MatchValuePicksResponseDTO = try await networkService.request(endpoint: endpoint)
    return responseDTO.toDomain()
  }
  
  func acceptMatch() async throws -> VoidModel {
    let endpoint = MatchesEndpoint.accept
    let responseDTO: VoidResponseDTO = try await networkService.request(endpoint: endpoint)
    return responseDTO.toDomain()
  }
  
  func refuseMatch() async throws -> VoidModel {
    let endpoint = MatchesEndpoint.refuse
    let responseDTO: VoidResponseDTO = try await networkService.request(endpoint: endpoint)
    return responseDTO.toDomain()
  }
}
