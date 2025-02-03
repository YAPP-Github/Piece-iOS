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
      AF.request(endpoint)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
          switch response.result {
          case .success(let data):
            continuation.resume(returning: data)
          case .failure(let error):
            continuation.resume(throwing: error)
          }
        }
    }
  }
}
