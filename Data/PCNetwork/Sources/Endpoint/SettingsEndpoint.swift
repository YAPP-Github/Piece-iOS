//
//  SettingsEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/16/25.
//

import Alamofire
import DTO

public enum SettingsEndpoint: TargetType {
  case blockContactsSyncTime
  
  public var method: Alamofire.HTTPMethod {
    switch self {
    case .blockContactsSyncTime: .get
    }
  }
  
  public var path: String {
    switch self {
    case .blockContactsSyncTime: "api/settings/blocks/contacts/sync-time"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .blockContactsSyncTime: [:]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .blockContactsSyncTime: .plain
    }
  }
}
