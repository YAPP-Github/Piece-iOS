//
//  LoginEndPoint.swift
//  PCNetwork
//
//  Created by eunseou on 2/7/25.
//

import SwiftUI
import Alamofire
import DTO

public enum LoginEndpoint: TargetType {
  case loginWithOAuth(body: SocialLoginRequsetDTO)
  
  public var headers: [String : String] {
    switch self {
    case .loginWithOAuth:
      [NetworkHeader.contentType: NetworkHeader.applicationJson]
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .loginWithOAuth:
        .post
    }
  }
  
  public var path: String {
    switch self {
    case .loginWithOAuth:
      "api/login/oauth"
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .loginWithOAuth(let body):
        .body(body)
    }
  }
}
