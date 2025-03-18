//
//  UserEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 3/5/25.
//

import Alamofire
import DTO
import LocalStorage

public enum UserEndpoint: TargetType {
  case withdrawWithPiece(WithdrawRequestDTO)
  case getUserRole
  case userReject
  
  public var method: Alamofire.HTTPMethod {
    switch self {
    case .withdrawWithPiece: .delete
    case .getUserRole: .get
    case .userReject: .get
    }
  }
  
  public var path: String {
    switch self {
    case .withdrawWithPiece: "api/users"
    case .getUserRole: "api/users/info"
    case .userReject: "api/users/reject"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .withdrawWithPiece:
      [
        NetworkHeader.contentType : NetworkHeader.applicationJson,
        NetworkHeader.authorization: NetworkHeader.bearer(PCKeychainManager.shared.read(.accessToken) ?? "")
      ]
    case .getUserRole:
      [
        NetworkHeader.authorization: NetworkHeader.bearer(PCKeychainManager.shared.read(.accessToken) ?? "")
      ]
    case .userReject:
      [
        NetworkHeader.authorization: NetworkHeader.bearer(PCKeychainManager.shared.read(.accessToken) ?? "")
      ]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case let .withdrawWithPiece(body): .body(body)
    case .getUserRole: .plain
    case .userReject: .plain
    }
  }
}

