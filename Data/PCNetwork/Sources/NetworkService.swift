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
  private let session: Session
  
  private init() {
    let interceptor = APIRequestInterceptor()
    self.session = Session(interceptor: interceptor)
  }
  
  public func request<T: Decodable>(endpoint: TargetType) async throws -> T {
    return try await withCheckedThrowingContinuation { continuation in
      session.request(endpoint)
        .validate()
        .responseDecodable(of: APIResponse<T>.self) { response in
          switch response.result {
          case .success(let apiResponse):
            print("\(apiResponse.status): \(apiResponse.message)")
            continuation.resume(returning: apiResponse.data)
          case .failure:
            guard let statusCode = response.response?.statusCode else {
              continuation.resume(throwing: NetworkError.decodingFailed)
              return
            }
            switch statusCode {
            case 400:
              let apiError: APIErrorModel? = try? JSONDecoder().decode(APIErrorModel.self, from: response.data ?? Data())
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
        case .failure:
          guard let statusCode = response.response?.statusCode else {
            continuation.resume(throwing: NetworkError.decodingFailed)
            return
          }
          switch statusCode {
          case 400:
            let apiError: APIErrorModel? = try? JSONDecoder().decode(APIErrorModel.self, from: response.data ?? Data())
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
              continuation.finish(throwing: error)
            }
            
          case let .complete(completion):
            guard let statusCode = completion.response?.statusCode else {
              continuation.finish(throwing: NetworkError.decodingFailed)
              return
            }
            
            switch statusCode {
            case 400:
              continuation.finish(throwing: NetworkError.badRequest(error: nil))
            case 401:
              continuation.finish(throwing: NetworkError.unauthorized)
            case 403:
              continuation.finish(throwing: NetworkError.forbidden)
            case 404:
              continuation.finish(throwing: NetworkError.notFound)
            case 500:
              continuation.finish(throwing: NetworkError.internalServerError)
            default:
              continuation.finish(throwing: NetworkError.statusCode(statusCode))
            }
          }
        }
      continuation.onTermination = { _ in
        request.cancel()
      }
    }
  }
}
