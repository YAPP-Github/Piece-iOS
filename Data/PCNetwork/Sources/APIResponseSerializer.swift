//
//  APIResponseSerializer.swift
//  PCNetwork
//
//  Created by summercat on 3/15/25.
//

import Alamofire
import Foundation

struct APIResponseSerializer<Success: Decodable>: ResponseSerializer {
  private let decoder = JSONDecoder()
  
  func serialize(
    request: URLRequest?,
    response: HTTPURLResponse?,
    data: Data?,
    error: (any Error)?
  ) throws -> Result<Success, NetworkError> {
    if let error {
      return .failure(.statusCode(error._code))
    }
    
    guard let data,
          !data.isEmpty else {
      return .failure(.emptyResponse)
    }
    
    guard let statusCode = response?.statusCode else {
      return .failure(.missingStatusCode)
    }
          
    guard 200..<300 ~= statusCode else {
      return .failure(NetworkError.from(statusCode: statusCode, data: data))
    }
    
    do {
      let apiResponse = try decoder.decode(APIResponse<Success>.self, from: data)
      return .success(apiResponse.data)
    } catch {
      print("Decoding error: \(error)")
      return .failure(.decodingFailed)
    }
  }
}

extension DataRequest {
    @discardableResult
    func responseAPI<T: Decodable>(
        of type: T.Type = T.self,
        queue: DispatchQueue = .main,
        completionHandler: @escaping (Result<T, NetworkError>) -> Void
    ) -> Self {
        return response(
            queue: queue,
            responseSerializer: APIResponseSerializer<T>()
        ) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result)
            case .failure(let error):
              if let afError = error.asAFError {
                // AFError를 NetworkError로 변환
                let networkError = NetworkError.from(afError: afError)
                completionHandler(.failure(networkError))
              } else {
                // 미분류 오류
                completionHandler(.failure(.statusCode(-1)))
              }
            }
        }
    }
}
