//
//  ValuePicksEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/10/25.
//

import Alamofire
import DTO
import Foundation

public enum ValuePicksEndpoint: TargetType {
  case getValuePicks
  
  public var method: HTTPMethod {
    switch self {
    case .getValuePicks: .get
    }
  }
  
  public var path: String {
    switch self {
    case .getValuePicks: "api/valuePicks"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .getValuePicks: [:]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .getValuePicks: .plain
    }
  }
}
