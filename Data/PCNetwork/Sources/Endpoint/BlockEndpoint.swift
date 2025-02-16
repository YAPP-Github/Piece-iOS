//
//  BlockEndpoint.swift
//  PCNetwork
//
//  Created by eunseou on 2/16/25.
//

import SwiftUI
import Alamofire
import DTO
import LocalStorage

public enum BlockEndpoint: TargetType {
  case postBlockContacts(body: BlockContactsRequestDTO)
  
  public var method: HTTPMethod {
    switch self {
    case .postBlockContacts:
        .post
    }
  }
  
  public var path: String {
    switch self {
    case .postBlockContacts:
      "api/blockContacts"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .postBlockContacts:
      [NetworkHeader.contentType:NetworkHeader.applicationJson,
       NetworkHeader.authorization:NetworkHeader.bearer(KeychainManager.shared.read(.accessToken) ?? "")]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case let .postBlockContacts(body):
        .body(body)
    }
  }
  
  
  
}
