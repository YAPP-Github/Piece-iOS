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
  
  public init (networkService: NetworkService) {
    self.networkService = networkService
  }
  
  public func socialLogin(
    providerName: SocialLoginType,
    token: String
  ) async throws -> SocialLoginResultModel {
    let body = SocialLoginRequsetDTO(providerName: providerName, token: token)
    let endpoint = LoginEndpoint.loginWithOAuth(body: body)
    
    let responseDTO: SocialLoginResponseDTO = try await networkService.request(endpoint: endpoint)
    return responseDTO.toDomain()
  }
  
  public func sendSMSCode(phoneNumber: String) async throws -> VoidModel {
    let body = SMSCodeRequestDTO(phoneNumber: phoneNumber)
    let endpoint = LoginEndpoint.sendSMSCode(body: body)
    let responseDTO: VoidResponseDTO = try await networkService.request(endpoint: endpoint)
    return responseDTO.toDomain()
  }
  
  public func verifySMSCode(phoneNumber: String, code: String) async throws -> SocialLoginResultModel {
    let body = VerifySMSCodeRequestDTO(phoneNumber: phoneNumber, code: code)
    let endpoint = LoginEndpoint.verifySMSCode(body: body)
    let responseDTO: SocialLoginResponseDTO = try await networkService.request(endpoint: endpoint)
    return responseDTO.toDomain()
  }
  
  public func checkTokenHealth(token: String) async throws -> VoidModel {
    let endpoint = LoginEndpoint.tokenHealthCheck(token: token)
    let responseDTO: VoidResponseDTO = try await networkService.request(endpoint: endpoint)
    return responseDTO.toDomain()
  }
}
