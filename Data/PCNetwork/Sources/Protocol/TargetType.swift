//
//  TargetType.swift
//  Network
//
//  Created by eunseou on 2/1/25.
//

import Foundation
import Alamofire

public protocol TargetType: URLRequestConvertible {
  var baseURL: String { get }
  var method: HTTPMethod { get }
  var path: String { get }
  var headers: [String: String] { get }
  var requestType: RequestType { get }
}

public extension TargetType {
  var baseURL: String {
    return NetworkConstants.baseURL
  }
  
  func asURLRequest() throws -> URLRequest {
    let baseURL = try baseURL.asURL()
    let url = baseURL.appendingPathComponent(path)
    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
    
    switch requestType {
    case .plain:
      guard let finalURL = components?.url else {
        throw NetworkError.notFound
      }
      return requestAPI(url: finalURL, httpBody: nil)
      
    case .query(let queryItems):
      components?.queryItems = queryItems
      guard let finalURL = components?.url else {
        throw NetworkError.notFound
      }
      return requestAPI(url: finalURL, httpBody: nil)
      
    case .body(let body):
      let jsonData = try body.encoded()
      return requestAPI(url: url, httpBody: jsonData)
      
    case .queryAndBodyParameters(let queryItems, let body):
      components?.queryItems = queryItems
      guard let finalURL = components?.url else {
        throw NetworkError.notFound
      }
      let jsonData = try body.encoded()
      return requestAPI(url: finalURL, httpBody: jsonData)
    }
  }
  
  private func requestAPI(url: URL, httpBody: Data?) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.allHTTPHeaderFields = headers
    request.httpBody = httpBody
    return request
  }
}
