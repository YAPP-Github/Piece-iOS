//
//  SSEEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/16/25.
//

import Alamofire
import DTO

public enum SSEEndpoint: TargetType {
  case connect
  case disconnect
  
  public var method: Alamofire.HTTPMethod {
    switch self {
    case .connect: .post
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
    case .connect: [:] // TODO: - 헤더 넣어야 하는지 확인
    case .disconnect: [:]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .connect: .plain
    case .disconnect: .plain
    }
  }
}

