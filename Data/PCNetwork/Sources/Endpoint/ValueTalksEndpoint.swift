//
//  ValueTalksEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/9/25.
//

import Alamofire
import DTO
import Foundation

public enum ValueTalksEndpoint: TargetType {
  case getValueTalks
  
  public var method: HTTPMethod {
    switch self {
    case .getValueTalks: .get
    }
  }
  
  public var path: String {
    switch self {
    case .getValueTalks: "api/valueTalks"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .getValueTalks: [:]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .getValueTalks: .plain
    }
  }
}
