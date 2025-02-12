//
//  ProfileEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/9/25.
// 

import Alamofire
import DTO
import Foundation

public enum ProfileEndpoint: TargetType {
  case postProfile(PostProfileRequestDTO)
  case getValuePicks
  case updateValuePicks([ValuePickRequestDTO])
  
  public var method: HTTPMethod {
    switch self {
    case .postProfile: .post
    case .getValuePicks: .get
    case .updateValuePicks: .put
    }
  }
  
  public var path: String {
    switch self {
    case .postProfile: "api/profiles"
    case .getValuePicks: "api/profiles/valuePicks"
    case .updateValuePicks: "api/profiles/valuePicks"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .postProfile: [:]
    case .getValuePicks: [:]
    case .updateValuePicks: [:]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case let .postProfile(dto): .body(dto)
    case .getValuePicks: .plain
    case let .updateValuePicks(dto): .body(dto)
    }
  }
}
