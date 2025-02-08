//
//  TermEndPoint.swift
//  Network
//
//  Created by eunseou on 2/5/25.
//

import Foundation
import Alamofire

public enum TermsEndPoint: TargetType {
  case fetchTermList
  
  public var headers: [String : String] {
    switch self {
    case .fetchTermList:
      [NetworkHeader.accept: NetworkHeader.all]
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .fetchTermList:
        .get
    }
  }
  
  public var path: String {
    switch self {
    case .fetchTermList:
      "api/terms"
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case .fetchTermList:
        .plain
    }
  }
}
