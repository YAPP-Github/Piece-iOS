//
//  NetworkService.swift
//  Network
//
//  Created by eunseou on 2/1/25.
//

import Foundation
import Alamofire

public class NetworkService {
  private let session: Session
  
  public init() {
    let interceptor = APIRequestInterceptor()
    self.session = Session(interceptor: interceptor)
  }
  
  public func request<T: Decodable>(endpoint: TargetType) async throws -> T {
    return try await withCheckedThrowingContinuation { continuation in
      session.request(endpoint)
        .validate()
        .responseDecodable(of: T.self) { response in
          switch response.result {
          case .success(let data):
            continuation.resume(returning: data)
          case .failure:
            let statusCode = response.response?.statusCode ?? -1
            let error: NetworkError = {
              switch statusCode {
              case 400: return .badRequest(error: nil)
              case 401: return .unauthorized
              case 403: return .forbidden
              case 404: return .notFound
              case 500: return .serverError
              default: return .statusCode(statusCode)
              }
            }()
            continuation.resume(throwing: error)
          }
        }
    }
  }
}
