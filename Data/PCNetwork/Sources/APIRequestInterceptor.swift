//
//  RequestInterceptor.swift
//  Network
//
//  Created by eunseou on 2/1/25.
//

import Alamofire
import DTO
import Foundation
import LocalStorage

class APIRequestInterceptor: RequestInterceptor {
  private let keychain: PCKeychainManager
  private let retryLimit = 3
  
  public init(keychain: PCKeychainManager = .shared) {
    self.keychain = keychain
  }
  
  func adapt(
    _ urlRequest: URLRequest,
    for session: Alamofire.Session,
    completion: @escaping (Result<URLRequest, Error>) -> Void
  ) {
    var request = urlRequest
//    if let accessToken = keychain.read(.accessToken) {
//      request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//    }
    completion(.success(request))
  }
  
  func retry(
    _ request: Request,
    for session: Alamofire.Session,
    dueTo error: Error,
    completion: @escaping (RetryResult) -> Void
  ) {
    guard let response = request.task?.response as? HTTPURLResponse,
          response.statusCode == 401 else {
      completion(.doNotRetryWithError(error))
      return
    }
    
    guard request.retryCount < retryLimit else {
      completion(.doNotRetryWithError(error))
      return
    }
    
    Task {
      do {
        guard let refreshToken = keychain.read(.refreshToken) else {
          completion(.doNotRetryWithError(NetworkError.unauthorized))
          return
        }
        
        // 토큰 갱신을 위한 요청 준비
        let baseURL = NetworkConstants.baseURL
        let url = try baseURL.asURL().appendingPathComponent("/api/login/token/refresh")
        
        let refreshRequestDTO = TokenRefreshRequestDTO(refreshToken: refreshToken)
        let requestBody = try JSONEncoder().encode(refreshRequestDTO)
        
        // 직접 AF.request 사용하여 토큰 갱신 요청
        let response = try await AF.request(
          url,
          method: .patch,
          headers: [NetworkHeader.contentType: NetworkHeader.applicationJson]
        )
          .authenticate(username: "", password: "")  // 기존 인증 헤더 무시
          .serializingDecodable(APIResponse<TokenRefreshResponseDTO>.self)
          .value
        
        // 새로운 토큰 저장
        keychain.save(.accessToken, value: response.data.accessToken)
        keychain.save(.refreshToken, value: response.data.refreshToken)
        
        completion(.retry)
      } catch {
        completion(.doNotRetryWithError(error))
      }
    }
  }
}
