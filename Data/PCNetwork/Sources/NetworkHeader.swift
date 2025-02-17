//
//  PCHeader.swift
//  Network
//
//  Created by eunseou on 2/1/25.
//

import Foundation

enum NetworkHeader {
  static let accept = "accept"
  static let all = "*/*"
  static let contentType = "Content-Type"
  static let applicationJson = "application/json"
  static let multipartFormData = "multipart/form-data"
  static let authorization = "Authorization"
  static func bearer(_ token: String) -> String {
    return "Bearer \(token)"
  }
  static let formUrlEncoded = "x-www-form-urlencoded"
  static let application = "application"
}
