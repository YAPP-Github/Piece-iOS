//
//  LoginEndPoint.swift
//  PCNetwork
//
//  Created by eunseou on 2/7/25.
//

import Alamofire
import DTO

public enum LoginEndpoint: TargetType {
  case loginWithOAuth(body: SocialLoginRequsetDTO)
  case socialLoginTokenRefresh(body: SocialLoginTokenRefreshRequestDTO)
  
  public var headers: [String : String] {
    switch self {
    case .loginWithOAuth: [NetworkHeader.contentType: NetworkHeader.applicationJson]
    case .socialLoginTokenRefresh: [NetworkHeader.contentType: NetworkHeader.applicationJson]
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .loginWithOAuth: .post
    case .socialLoginTokenRefresh: .patch
    }
  }
  
  public var path: String {
    switch self {
    case .loginWithOAuth: "api/login/oauth"
    case .socialLoginTokenRefresh: "/api/login/token/refresh"
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .loginWithOAuth(let body): .body(body)
    case let .socialLoginTokenRefresh(body): .body(body)
    }
  }
}
