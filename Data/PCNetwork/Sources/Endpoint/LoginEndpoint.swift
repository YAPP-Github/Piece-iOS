//
//  LoginEndPoint.swift
//  PCNetwork
//
//  Created by eunseou on 2/7/25.
//

import Alamofire
import DTO
import Foundation
import LocalStorage

public enum LoginEndpoint: TargetType {
  case loginWithOAuth(body: SocialLoginRequsetDTO)
  case sendSMSCode(body: SMSCodeRequestDTO)
  case verifySMSCode(body: VerifySMSCodeRequestDTO)
  case tokenRefresh(body: TokenRefreshRequestDTO)
  case tokenHealthCheck(token: String)
  
  public var headers: [String : String] {
    switch self {
    case .loginWithOAuth:
      [NetworkHeader.contentType: NetworkHeader.applicationJson]
    case .sendSMSCode:
      [
        NetworkHeader.contentType: NetworkHeader.applicationJson,
        NetworkHeader.authorization: NetworkHeader.bearer(PCKeychainManager.shared.read(.accessToken) ?? "")
      ]
    case .verifySMSCode:
      [
        NetworkHeader.contentType: NetworkHeader.applicationJson,
        NetworkHeader.authorization: NetworkHeader.bearer(PCKeychainManager.shared.read(.accessToken) ?? "")
      ]
    case .tokenRefresh(body: let body):
      [
        NetworkHeader.contentType: NetworkHeader.applicationJson
      ]
    case .tokenHealthCheck: [:]
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .loginWithOAuth:
        .post
    case .sendSMSCode:
        .post
    case .verifySMSCode:
        .post
    case .tokenRefresh: .patch
    case .tokenHealthCheck: .get
    }
  }
  
  public var path: String {
    switch self {
    case .loginWithOAuth:
      "api/login/oauth"
    case .sendSMSCode:
      "api/register/sms/auth/code"
    case .verifySMSCode:
      "api/register/sms/auth/code/verify"
    case .tokenRefresh:
      "api/login/token/refresh"
    case let .tokenHealthCheck(parameters):
      "api/login/token/health-check/"
      
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .loginWithOAuth(let body):
        .body(body)
    case .sendSMSCode(let body):
        .body(body)
    case .verifySMSCode(let body):
        .body(body)
    case let .tokenRefresh(body):
        .body(body)
    case let .tokenHealthCheck(token): .query([URLQueryItem(name: "token", value: token)])
    }
  }
}
