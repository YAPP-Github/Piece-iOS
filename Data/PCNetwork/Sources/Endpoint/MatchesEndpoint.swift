//
//  MatchesEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/11/25.
//

import Alamofire
import DTO
import Foundation
import LocalStorage

public enum MatchesEndpoint: TargetType {
  case profileBasic
  case valueTalks
  case valuePicks
  case accept
  case matchesInfos
  
  public var method: HTTPMethod {
    switch self {
    case .profileBasic: .get
    case .valueTalks: .get
    case .valuePicks: .get
    case .accept: .post
    case .matchesInfos: .get
    }
  }
  
  public var path: String {
    switch self {
    case .profileBasic: "api/matches/profiles/basic"
    case .valueTalks: "api/matches/values/talks"
    case .valuePicks: "api/matches/values/picks"
    case .accept: "api/matches/accept"
    case .matchesInfos: "api/matches/infos"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .profileBasic: [NetworkHeader.authorization: NetworkHeader.bearer(KeychainManager.shared.read(.accessToken) ?? "")]
    case .valueTalks: [:]
    case .valuePicks: [:]
    case .accept: [:]
    case .matchesInfos: [NetworkHeader.authorization: NetworkHeader.bearer(KeychainManager.shared.read(.accessToken) ?? "")]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .profileBasic: .plain
    case .valueTalks: .plain
    case .valuePicks: .plain
    case .accept: .plain
    case .matchesInfos: .plain
    }
  }
}
