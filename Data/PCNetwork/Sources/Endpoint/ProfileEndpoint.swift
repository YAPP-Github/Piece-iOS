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
  
  public var method: HTTPMethod {
    switch self {
    case .postProfile: .post
    }
  }
  
  public var path: String {
    switch self {
    case .postProfile: "api/profiles"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .postProfile: [:]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case let .postProfile(dto): .body(dto)
    }
  }
}
