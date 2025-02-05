//
//  NetworkError.swift
//  Network
//
//  Created by eunseou on 2/2/25.
//

import Foundation

public enum NetworkError: LocalizedError {
  case badRequest(error: APIError?)  //400
  case unauthorized //401
  case forbidden // 403
  case notFound //404
  case statusCode(Int)
  
  public var errorDescription: String? {
    switch self {
    case .badRequest(let apiError):
      if let error = apiError {
        return error.message
      }
      return "잘못된 요청입니다"
    case .unauthorized:
      return "인증되지 않은 요청입니다"
    case .forbidden:
      return "접근이 거부되었습니다"
    case .notFound:
      return "리소스를 찾을 수 없습니다"
    case .statusCode(let int):
      return "Status Code: \(int) 에러가 발생했습니다"
    }
  }
}
