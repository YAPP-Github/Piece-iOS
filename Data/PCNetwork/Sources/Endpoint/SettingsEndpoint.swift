//
//  SettingsEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/19/25.
//

import Alamofire

public enum SettingsEndpoint: TargetType {
  case fetchBlockContactsSyncTime
  
  public var headers: [String : String] {
    switch self {
    case .fetchBlockContactsSyncTime:
      [NetworkHeader.accept: NetworkHeader.all]
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .fetchBlockContactsSyncTime: .get
    }
  }
  
  public var path: String {
    switch self {
    case .fetchBlockContactsSyncTime: "api/settings/blocks/contacts/sync-time"
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .fetchBlockContactsSyncTime: .plain
    }
  }
}

