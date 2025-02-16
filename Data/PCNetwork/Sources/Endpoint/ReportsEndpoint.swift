//
//  ReportsEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/16/25.
//

import Alamofire
import DTO

public enum ReportsEndpoint: TargetType {
  case report
  
  public var method: Alamofire.HTTPMethod {
    switch self {
    case .report: .post
    }
  }
  
  public var path: String {
    switch self {
    case .report: "api/reports"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .report: [:]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .report: .plain
    }
  }
}
