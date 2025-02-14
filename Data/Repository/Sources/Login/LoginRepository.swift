//
//  LoginRepository.swift
//  Repository
//
//  Created by eunseou on 2/8/25.
//

import SwiftUI
import DTO
import PCNetwork
import Entities
import RepositoryInterfaces

public final class LoginRepository: LoginRepositoryInterfaces {
  
  private let networkService: NetworkService
  
  public init (networkService: NetworkService = NetworkService()) {
    self.networkService = networkService
  }
  
  public func socialLogin(providerName: SocialLoginType, token: String) async throws -> SocialLoginResultModel {
    let body = SocialLoginRequsetDTO(providerName: providerName, token: token)
    let endpoint = LoginEndpoint.loginWithOAuth(body: body)
    
    let responseDTO: SocialLoginResponseDTO = try await networkService.request(endpoint: endpoint)
    return responseDTO.toDomain()
  }
}
