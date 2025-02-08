//
//  NetworkConstant.swift
//  Network
//
//  Created by eunseou on 2/1/25.
//

import Foundation

public enum NetworkConstants {
  static let baseURL: String = {
    guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
      fatalError("BASE_URL not found in Info.plist")
    }
    return baseURL
  }()
}
