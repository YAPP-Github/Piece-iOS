//
//  NetworkService.swift
//  Network
//
//  Created by eunseou on 2/1/25.
//

import DTO
import Foundation
import Alamofire
import LocalStorage

public class NetworkService {
  public static let shared = NetworkService()
  private var session: Session
  
  private init() {
    let credential = OAuthCredential(
      accessToken: PCKeychainManager.shared.read(.accessToken) ?? "",
      refreshToken: PCKeychainManager.shared.read(.refreshToken) ?? "",
      expiration: Date(timeIntervalSinceNow: 60 * 60 * 24)
    )
    let authenticator = OAuthAuthenticator()
    let interceptor = AuthenticationInterceptor(authenticator: authenticator, credential: credential)
    self.session = Session(interceptor: interceptor)
  }
  
  public func request<T: Decodable>(endpoint: TargetType) async throws -> T {
    print("request path: \(endpoint.path)")
    
    return try await withCheckedThrowingContinuation { continuation in
      session.request(endpoint)
        .validate()
        .responseDecodable(of: APIResponse<T>.self) { response in
          switch response.result {
          case .success(let apiResponse):
            print("\(apiResponse.status): \(apiResponse.message)")
            continuation.resume(returning: apiResponse.data)
          case .failure(let error):
            if let afError = error.asAFError {
              let networkError = NetworkError.from(afError: afError)
              continuation.resume(throwing: networkError)
            } else {
              continuation.resume(throwing: NetworkError.statusCode(-1))
            }
          }
        }
    }
  }
  
  public func requestWithoutAuth<T: Decodable>(endpoint: TargetType) async throws -> T {
    return try await withCheckedThrowingContinuation { continuation in
      AF.request(endpoint)
        .validate()
        .responseDecodable(of: APIResponse<T>.self) { response in
          switch response.result {
          case .success(let apiResponse):
            print("\(apiResponse.status): \(apiResponse.message)")
            continuation.resume(returning: apiResponse.data)
          case .failure(let error):
            if let afError = error.asAFError {
              let networkError = NetworkError.from(afError: afError)
              continuation.resume(throwing: networkError)
            } else {
              continuation.resume(throwing: NetworkError.statusCode(-1))
            }
          }
        }
    }
  }
  
  public func uploadImage<T: Decodable>(endpoint: TargetType, imageData: Data) async throws -> T {
    return try await withCheckedThrowingContinuation { continuation in
      session.upload(
        multipartFormData: {
          $0.append(
            imageData,
            withName: "file",
            fileName: "image.jpg",
            mimeType: "image/png"
          )
        },
        with: endpoint)
      .validate()
      .responseDecodable(of: APIResponse<T>.self) { response in
        switch response.result {
        case .success(let apiResponse):
          continuation.resume(returning: apiResponse.data)
        case .failure(let error):
          if let afError = error.asAFError {
            let networkError = NetworkError.from(afError: afError)
            continuation.resume(throwing: networkError)
          } else {
            continuation.resume(throwing: NetworkError.statusCode(-1))
          }
        }
      }
    }
  }
  
  public func connectSse(endpoint: TargetType) -> AsyncThrowingStream<ProfileValueTalkAISummaryResponseDTO, Error> {
    return AsyncThrowingStream { continuation in
      let request = session.streamRequest(endpoint)
        .validate()
        .responseStream { stream in
          switch stream.event {
          case let .stream(result):
            switch result {
            case let .success(data):
              do {
                let decodedData = try JSONDecoder().decode(ProfileValueTalkAISummaryResponseDTO.self, from: data)
                continuation.yield(decodedData)
              } catch {
                continuation.finish(throwing: NetworkError.decodingFailed)
              }
            case let .failure(error):
              if let afError = error.asAFError {
                let networkError = NetworkError.from(afError: afError)
                continuation.finish(throwing: networkError)
              } else {
                continuation.finish(throwing: error)
              }
            }
            
          case let .complete(completion):
            // 스트림 완료 처리
            if let error = completion.error {
              // AFError가 있으면 변환
              continuation.finish(throwing: NetworkError.from(afError: error))
            } else if let statusCode = completion.response?.statusCode,
                        !(200..<300).contains(statusCode) {
              // 성공이 아닌 상태 코드가 있으면 변환
              let networkError = NetworkError.from(statusCode: statusCode, data: nil)
              continuation.finish(throwing: networkError)
            } else if completion.response == nil {
              // 응답이 없으면 missingStatusCode
              continuation.finish(throwing: NetworkError.missingStatusCode)
            } else {
              // 정상 종료
              continuation.finish()
            }
          }
        }
      continuation.onTermination = { _ in
        request.cancel()
      }
    }
  }
  
  public func updateCredentials() {
    let accessToken = PCKeychainManager.shared.read(.accessToken) ?? ""
    let refreshToken = PCKeychainManager.shared.read(.refreshToken) ?? ""
    
    print("Session 업데이트 - Access Token: \(accessToken)")
    print("Session 업데이트 - Refresh Token: \(refreshToken)")
    
    let credential = OAuthCredential(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiration: Date(timeIntervalSinceNow: 60 * 60)
    )
    
    let authenticator = OAuthAuthenticator()
    let interceptor = AuthenticationInterceptor(authenticator: authenticator, credential: credential)
    self.session = Session(interceptor: interceptor)
  }
}
