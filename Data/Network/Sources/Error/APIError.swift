//
//  APIError.swift
//  Network
//
//  Created by eunseou on 2/2/25.
//

import Foundation

public struct APIError: Decodable {
  public let code: String
  public let message: String
  public let errors: [FieldMessage]?
  
  public struct FieldMessage: Decodable {
    public let field: String
    public let message: String
  }
}
