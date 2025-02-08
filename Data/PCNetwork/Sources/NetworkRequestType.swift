//
//  NetworkRequestType.swift
//  Network
//
//  Created by eunseou on 2/2/25.
//

import Foundation
import Alamofire

public enum RequestType {
  case plain
  case query(_ query: [URLQueryItem])
  case body(_ body: Encodable)
  case queryAndBodyParameters(
    query: [URLQueryItem],
    body: Encodable
  )
}
