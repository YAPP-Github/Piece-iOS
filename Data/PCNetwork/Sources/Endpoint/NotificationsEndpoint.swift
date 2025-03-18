//
//  NotificationsEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 3/15/25.
//

import Alamofire
import DTO
import Foundation
import LocalStorage

public enum NotificationsEndpoint: TargetType {
  case notifications(cursor: Int?)
  
  public var method: HTTPMethod {
    switch self {
    case .notifications:
        .get
    }
  }
  
  public var path: String {
    switch self {
    case .notifications:
      "api/notifications"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .notifications:
      [NetworkHeader.contentType:NetworkHeader.applicationJson,
       NetworkHeader.authorization:NetworkHeader.bearer(PCKeychainManager.shared.read(.accessToken) ?? "")]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case let .notifications(cursor):
      var queryItems = [URLQueryItem]()
      if let cursor {
        let queryItem = URLQueryItem(name: "cursor", value: "\(cursor)")
        queryItems.append(queryItem)
      }
      return .query(queryItems)
    }
  }
}

