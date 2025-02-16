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
  
  public init (networkService: NetworkService) {
    self.networkService = networkService
  }
  
  func postProfile(_ profile: ProfileModel) async throws -> PostProfileResultModel {
    let dto = profile.toDto()
    let endpoint = ProfileEndpoint.postProfile(dto)
    let responseDto: PostProfileResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return responseDto.toDomain()
  }
  
  func getProfileValueTalks() async throws -> [ProfileValueTalkModel] {
    let endpoint = ProfileEndpoint.getValueTalks
    let responseDto: ProfileValueTalksResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return responseDto.responses.map { $0.toDomain() }
  }
  
  func updateProfileValueTalks(_ valueTalks: [ProfileValueTalkModel]) async throws -> VoidModel {
    let requests = valueTalks.map { ProfileValueTalkRequestDTO(profileValueTalkId: $0.id, answer: $0.answer, summary: $0.summary) }
    let requestDto = ProfileValueTalksRequestDTO(profileValueTalkUpdateRequests: requests)
    let endpoint = ProfileEndpoint.updateValueTalks(requestDto)
    let responseDto: VoidResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return responseDto.toDomain()
  }
  
  func updateProfileValueTalkSummary(profileTalkId: Int, summary: String) async throws -> Entities.VoidModel {
    let requestDto = ProfileValueTalkSummaryRequestDTO(summary: summary)
    let endpoint = ProfileEndpoint.updateValueTalkSummary(profileTalkId: profileTalkId, dto: requestDto)
    let responseDto: VoidResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return responseDto.toDomain()
  }
  
  func getProfileValuePicks() async throws -> [ProfileValuePickModel] {
    let endpoint = ProfileEndpoint.getValuePicks
    let responseDto: ProfileValuePicksResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return responseDto.responses.map { $0.toDomain() }
  }
  
  func updateProfileValuePicks(_ valuePicks: [ProfileValuePickModel]) async throws -> VoidModel {
    let requests = valuePicks.map {
      ProfileValuePickRequestDTO(
        profileValuePickId: $0.id,
        selectedAnswer: $0.selectedAnswer ?? 0
      )
    }
    let requestDto = ProfileValuePicksRequestDTO(profileValuePickUpdateRequests: requests)
    let endpoint = ProfileEndpoint.updateValuePicks(requestDto)
    let responseDto: VoidResponseDTO = try await networkService.request(endpoint: endpoint)
    
    return responseDto.toDomain()
  }
  
  func uploadProfileImage(_ imageData: Data) async throws -> URL {
    let endpoint = ProfileEndpoint.postUploadImage(imageData)
    
    return try await networkService.uploadImage(endpoint: endpoint, imageData: imageData)
  }
}
