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
  case valueTalks
  
  public var method: HTTPMethod {
    switch self {
    case .profileBasic: .get
    case .valueTalks: .get
    }
  }
  
  public var path: String {
    switch self {
    case .profileBasic: "api/matches/profiles/basic"
    case .valueTalks: "api/matches/values/talks"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .profileBasic: [:]
    case .valueTalks: [:]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .profileBasic: .plain
    case .valueTalks: .plain
    }
  }
}
