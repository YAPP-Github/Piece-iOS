//
//  SSEEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/16/25.
//

import Alamofire
import DTO
import LocalStorage

public enum SSEEndpoint: TargetType {
  case connect
  case disconnect
  
  public var method: Alamofire.HTTPMethod {
    switch self {
    case .connect: .get
    case .disconnect: .delete
    }
  }
  
  public var path: String {
    switch self {
    case .connect: "api/sse/personal/connect"
    case .disconnect: "api/sse/personal/disconnect"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .connect:
      [NetworkHeader.authorization: NetworkHeader.bearer(PCKeychainManager.shared.read(.accessToken) ?? "")]
    case .disconnect:
      [NetworkHeader.authorization: NetworkHeader.bearer(PCKeychainManager.shared.read(.accessToken) ?? "")]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .connect: .plain
    case .disconnect: .plain
    }
  }
}

