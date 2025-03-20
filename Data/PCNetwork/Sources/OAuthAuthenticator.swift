//
//  OAuthAuthenticator.swift
//  PCNetwork
//
//  Created by summercat on 3/11/25.
//

import Alamofire
import DTO
import Foundation
import LocalStorage

final class OAuthAuthenticator: Authenticator {
  private let lock = NSLock()
  private var isRefreshing = false
  private var retryCount = 0
  private let maxRetryCount = 3
  
  func apply(
    _ credential: OAuthCredential,
    to urlRequest: inout URLRequest
  ) {
    urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
  }
  
  func didRequest(
    _ urlRequest: URLRequest,
    with response: HTTPURLResponse,
    failDueToAuthenticationError error: any Error
  ) -> Bool {
    // If authentication server CANNOT invalidate credentials, return `false`
    //    return false
    
    // If authentication server CAN invalidate credentials, then inspect the response matching against what the
    // authentication server returns as an authentication failure. This is generally a 401 along with a custom
    // header value.
    return response.statusCode == 401
  }
  
  func isRequest(
    _ urlRequest: URLRequest,
    authenticatedWith credential: OAuthCredential
  ) -> Bool {
    // If authentication server CANNOT invalidate credentials, return `true`
    //    return true
    
    // If authentication server CAN invalidate credentials, then compare the "Authorization" header value in the
    // `URLRequest` against the Bearer token generated with the access token of the `Credential`.
    let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
    return urlRequest.headers["Authorization"] == bearerToken
  }
  
  func refresh(
    _ credential: OAuthCredential,
    for session: Session,
    completion: @escaping (Result<OAuthCredential, any Error>) -> Void
  ) {
    lock.lock()
    
    if isRefreshing {
      lock.unlock()
      print("🛰 Token refresh already in progress")
      return
    }
    
    if retryCount >= maxRetryCount {
      lock.unlock()
      print("🛰 Maximum refresh attemps reached (\(maxRetryCount)")
      PCKeychainManager.shared.delete(.accessToken)
      PCKeychainManager.shared.delete(.refreshToken)
      completion(.failure(NetworkError.noRefreshToken))
      return
    }
      
    retryCount += 1
    print("🛰 Token refresh attempt \(retryCount) of \(maxRetryCount)")
    isRefreshing = true
    lock.unlock()
    
    defer {
      lock.lock()
      isRefreshing = false
      lock.unlock()
    }
    
    guard !credential.refreshToken.isEmpty else {
      print("🛰 Refresh Token 없음")
      PCKeychainManager.shared.delete(.accessToken)
      PCKeychainManager.shared.delete(.refreshToken)
      completion(.failure(NetworkError.noRefreshToken))
      return
    }
    
    print("🛰 토큰 재발급")
    print("🛰 refresh token: \(credential.refreshToken)")
    let requestDto = TokenRefreshRequestDTO(refreshToken: credential.refreshToken)
    let endpoint = LoginEndpoint.tokenRefresh(body: requestDto)
    let url = endpoint.baseURL.appending(endpoint.path)
    print(url)
    
    AF.request(url, method: .patch, parameters: requestDto, encoder: JSONParameterEncoder())
      .responseAPI(of: TokenRefreshResponseDTO.self) { result in
        switch result {
        case .success(let tokenData):
          let accessToken = tokenData.accessToken
          let refreshToken = tokenData.refreshToken
          print("🛰 토큰 재발급 성공")
          print("🛰 Access Token: \(accessToken)")
          print("🛰 Refresh Token: \(refreshToken)")
          
          self.lock.lock()
          self.retryCount = 0
          self.lock.unlock()
          
          PCKeychainManager.shared.save(.accessToken, value: accessToken)
          PCKeychainManager.shared.save(.refreshToken, value: refreshToken)
          
          let newCredential = OAuthCredential(
            accessToken: accessToken,
            refreshToken: refreshToken,
            expiration: Date(timeIntervalSinceNow: 60 * 60)
          )
          completion(.success(newCredential))
          
        case .failure(let networkError):
          print("🛰 토큰 재발급 실패: \(networkError.errorDescription ?? "알 수 없는 오류")")
          // 토큰 갱신 실패 시 키체인에서 토큰 삭제
          PCKeychainManager.shared.delete(.accessToken)
          PCKeychainManager.shared.delete(.refreshToken)
          
          // networkError가 이미 적절한 타입이므로 그대로 전달
          completion(.failure(networkError))
        }
      }
  }
}
