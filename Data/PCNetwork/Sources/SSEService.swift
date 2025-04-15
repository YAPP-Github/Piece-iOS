//
//  SSEService.swift
//  PCNetwork
//
//  Created by summercat on 4/8/25.
//

import Alamofire
import DTO
import Entities
import Foundation

public final class SSEService {
  public static let shared = SSEService()
  private let session: Session
  
  private init() {
    self.session = Session.default
  }
  
  public func connectSSE(endpoint: TargetType) -> AsyncThrowingStream<ProfileValueTalkAISummaryResponseDTO, Error> {
    let url = endpoint.baseURL + endpoint.path
    let headers: [HTTPHeader] = endpoint.headers.map { key, value in
      HTTPHeader(name: key, value: value)
    }
    print("📡 SSE connect url: \(url)")
    
    return AsyncThrowingStream { continuation in
      session
        .eventSourceRequest(
          url,
          method: endpoint.method,
          headers: HTTPHeaders(headers)
        )
        .responseEventSource { eventSource in
          switch eventSource.event {
          case let .message(message):
            print("📡 SSE message: \(message)")
            guard let data = message.data else {
              continuation.finish(throwing: NetworkError.emptyResponse)
              return
            }
            
            guard let jsonData = data.data(using: .utf8) else {
              continuation.finish(throwing: NetworkError.decodingFailed)
              return
            }
            
            let decoder = JSONDecoder()
            guard let dto = try? decoder.decode(
              ProfileValueTalkAISummaryResponseDTO.self,
              from: jsonData
            ) else {
              continuation.finish(throwing: NetworkError.decodingFailed)
              return
            }
            
            continuation.yield(dto)
          case let .complete(completion):
            print("📡 SSE complete: \(completion)")
          }
        }
    }
  }
  
  public func disconnectSSE<T: Decodable>(endpoint: TargetType) async throws -> T {
    return try await withCheckedThrowingContinuation { continuation in
      session.request(endpoint)
        .validate()
        .responseDecodable(of: APIResponse<T>.self) { response in
          switch response.result {
          case .success(let apiResponse):
            print("📡 API Response \(apiResponse.status): \(apiResponse.message)")
            continuation.resume(returning: apiResponse.data)
          case .failure(let error):
            if let afError = error.asAFError {
              let networkError = NetworkError.from(afError: afError)
              print("📡 NetworkError Description: \(networkError.errorDescription)")
              continuation.resume(throwing: networkError)
            } else {
              continuation.resume(throwing: NetworkError.statusCode(-1))
            }
          }
        }
    }
  }
}
