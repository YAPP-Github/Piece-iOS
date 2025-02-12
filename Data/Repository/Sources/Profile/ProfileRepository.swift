//
//  ProfileRepository.swift
//  Repository
//
//  Created by summercat on 2/9/25.
//

import DTO
import Entities
import Foundation
import PCNetwork
import RepositoryInterfaces

final class ProfileRepository: ProfileRepositoryInterface {
  private let networkService: NetworkService
  
  public init (networkService: NetworkService = NetworkService()) {
    self.networkService = networkService
  }
  
  func postProfile(_ profile: ProfileModel) async throws -> PostProfileResultModel {
    let dto = profile.toDto()
    let endpoint = ProfileEndpoint.postProfile(dto)
    let responseDto: PostProfileResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return responseDto.toDomain()
  }
  
  func getProfileValuePicks() async throws -> [ValuePickModel] {
    let endpoint = ProfileEndpoint.getValuePicks
    let responseDto: ProfileValuePicksResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return responseDto.responses.map { $0.toDomain() }
  }
}
