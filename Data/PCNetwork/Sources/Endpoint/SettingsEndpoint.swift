//
//  SettingsEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/19/25.
//

import Alamofire
import LocalStorage

public enum SettingsEndpoint: TargetType {
  case fetchBlockContactsSyncTime
  case patchLogout
  
  public var headers: [String : String] {
    switch self {
    case .fetchBlockContactsSyncTime:
      [NetworkHeader.accept: NetworkHeader.all]
    case .patchLogout:
      [NetworkHeader.authorization: NetworkHeader.bearer(PCKeychainManager.shared.read(.accessToken) ?? "")]
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .fetchBlockContactsSyncTime: .get
    case .patchLogout: .patch
    }
  }
  
  public var path: String {
    switch self {
    case .fetchBlockContactsSyncTime: "api/settings/blocks/contacts/sync-time"
    case .patchLogout: "api/logout"
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .fetchBlockContactsSyncTime: .plain
    case .patchLogout: .plain
    }
  }
}

