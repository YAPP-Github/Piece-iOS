//
//  Encodable+Extension.swift
//  Network
//
//  Created by eunseou on 2/3/25.
//

import Foundation

extension Encodable {
  func encoded() throws -> Data {
    do {
      return try JSONEncoder().encode(self)
    } catch {
      throw NetworkError.encodingFailed
    }
  }
}
