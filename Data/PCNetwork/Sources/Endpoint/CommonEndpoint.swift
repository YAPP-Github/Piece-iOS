//
//  CommonEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/15/25.
//

import Alamofire
import DTO

public enum CommonEndpoint: TargetType {
  case healthCheck
  
  public var method: Alamofire.HTTPMethod {
    switch self {
    case .healthCheck: .get
    }
  }
  
  public var path: String {
    switch self {
    case .healthCheck: "api/common/health"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .healthCheck: [:]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .healthCheck: .plain
    }
  }
}
