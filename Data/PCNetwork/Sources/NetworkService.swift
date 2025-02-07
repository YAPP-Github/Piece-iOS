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
            guard let statusCode = response.response?.statusCode else {
              continuation.resume(throwing: NetworkError.decodingFailed)
              return
            }
            switch statusCode {
            case 400:
              let apiError: APIError? = try? JSONDecoder().decode(APIError.self, from: response.data ?? Data())
              continuation.resume(throwing: NetworkError.badRequest(error: apiError))
            case 401:
              continuation.resume(throwing: NetworkError.unauthorized)
            case 403:
              continuation.resume(throwing: NetworkError.forbidden)
            case 404:
              continuation.resume(throwing: NetworkError.notFound)
            case 500:
              continuation.resume(throwing: NetworkError.internalServerError)
            default:
              continuation.resume(throwing: NetworkError.statusCode(statusCode))
            }
          }
        }
    }
  }
}
