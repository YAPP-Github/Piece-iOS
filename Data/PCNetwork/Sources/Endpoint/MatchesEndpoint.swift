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
  case valuePicks
  case accept
  case refuse
  
  public var method: HTTPMethod {
    switch self {
    case .profileBasic: .get
    case .valueTalks: .get
    case .valuePicks: .get
    case .accept: .post
    case .refuse: .put
    }
  }
  
  public var path: String {
    switch self {
    case .profileBasic: "api/matches/profiles/basic"
    case .valueTalks: "api/matches/values/talks"
    case .valuePicks: "api/matches/values/picks"
    case .accept: "api/matches/accept"
    case .refuse: "api/matches/refuse"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .profileBasic: [:]
    case .valueTalks: [:]
    case .valuePicks: [:]
    case .accept: [:]
    case .refuse: [:]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .profileBasic: .plain
    case .valueTalks: .plain
    case .valuePicks: .plain
    case .accept: .plain
    case .refuse: .plain
    }
  }
}
