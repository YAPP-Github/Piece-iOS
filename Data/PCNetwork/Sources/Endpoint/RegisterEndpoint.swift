//
//  RegisterEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 4/16/25.
//

import Alamofire
import DTO
import Foundation
import LocalStorage

public enum RegisterEndpoint: TargetType {
  case sendSMSCode(body: SMSCodeRequestDTO)
  case verifySMSCode(body: VerifySMSCodeRequestDTO)

  
  public var headers: [String : String] {
    switch self {
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
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .sendSMSCode: .post
    case .verifySMSCode: .post
    }
  }
  
  public var path: String {
    switch self {
    case .sendSMSCode:
      "api/register/sms/auth/code"
    case .verifySMSCode:
      "api/register/sms/auth/code/verify"
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .sendSMSCode(let body):
        .body(body)
    case .verifySMSCode(let body):
        .body(body)
    }
  }
}
