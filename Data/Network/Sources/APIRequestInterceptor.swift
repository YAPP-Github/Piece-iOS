//
//  RequestInterceptor.swift
//  Network
//
//  Created by eunseou on 2/1/25.
//

import Foundation
import Alamofire
import LocalStorage

class APIRequestInterceptor: RequestInterceptor {
  private let keychain: KeychainManager
  
  public init(keychain: KeychainManager = .shared) {
    self.keychain = keychain
  }
  
  func adapt(_ urlRequest: URLRequest, for session: Alamofire.Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
    var request = urlRequest
    if let accessToken = keychain.read(.accessToken) {
      request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }
    completion(.success(request))
  }
  
  func retry(_ request: Request, for session: Alamofire.Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
    guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
      completion(.doNotRetryWithError(error))
      return
    }
    
    Task {
      do {
        // TODO: - refreshToken 메서드 적용
        //let newToken = try await refreshAccessToken()
        //keychain.save(.accessToken, value: newToken)
        completion(.retry)
      } catch {
        completion(.doNotRetryWithError(error))
      }
    }
  }
}
