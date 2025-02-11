//
//  MatchesEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/11/25.
//

import Alamofire
import DTO
import Foundation

public enum MatchesEndpoint: TargetType {
  case profileBasic
  
  public var method: HTTPMethod {
    switch self {
    case .profileBasic: .get
    }
  }
  
  public var path: String {
    switch self {
    case .profileBasic: "api/matches/profiles/basic"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .profileBasic: [:]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .profileBasic: .plain
    }
  }
}
