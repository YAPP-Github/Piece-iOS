//
//  NetworkError.swift
//  Network
//
//  Created by eunseou on 2/2/25.
//

import Foundation

public enum NetworkError: LocalizedError {
  case badRequest(error: APIErrorModel?)  //400
  case unauthorized(error: APIErrorModel?) //401
  case forbidden // 403
  case notFound //404
  case internalServerError // 500
  case statusCode(Int)
  case missingStatusCode
  case emptyResponse
  case encodingFailed
  case decodingFailed
  case noRefreshToken
  
  public var errorDescription: String? {
    switch self {
    case .badRequest(let apiError):
      if let error = apiError {
        return error.message
      }
      return "잘못된 요청입니다"
    case .unauthorized(let apiError):
      if let error = apiError {
        return error.message
      }
      return "인증되지 않은 요청입니다"
    case .forbidden:
      return "접근이 거부되었습니다"
    case .notFound:
      return "리소스를 찾을 수 없습니다"
    case .statusCode(let int):
      return "Status Code: \(int) 에러가 발생했습니다"
    case .missingStatusCode:
      return "HTTPURLResponse에 Status Code가 없습니다"
    case .emptyResponse:
      return "응답 데이터가 비어있습니다"
    case .encodingFailed:
      return "인코딩에 실패했습니다"
    case .decodingFailed:
      return "디코딩에 실패했습니다"
    case .internalServerError:
      return "서버 오류가 발생했습니다"
    case .noRefreshToken:
      return "Refresh Token이 없습니다"
    }
  }
}
