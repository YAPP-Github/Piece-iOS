//
//  CommonEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/15/25.
//

import Alamofire
import DTO
import LocalStorage

public enum CommonEndpoint: TargetType {
  case healthCheck
  case withdrawWithPiece(WithdrawRequestDTO)
  
  public var method: Alamofire.HTTPMethod {
    switch self {
    case .healthCheck: .get
    case .withdrawWithPiece: .delete
    }
  }
  
  public var path: String {
    switch self {
    case .healthCheck: "api/common/health"
    case .withdrawWithPiece: "api/users"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .healthCheck: [:]
    case .withdrawWithPiece: [NetworkHeader.contentType : NetworkHeader.applicationJson,
                     NetworkHeader.authorization: NetworkHeader.bearer(PCKeychainManager.shared.read(.accessToken) ?? "")]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .healthCheck: .plain
    case let .withdrawWithPiece(body): .body(body)
    }
  }
}
