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
  var parameters: String? { get }
  var queryItems: [URLQueryItem]? { get }
  var body: Data? { get }
}

extension TargetType {
  var baseURL: String {
    return NetworkConstants.baseURL
  }
  
  var headers: HTTPHeaders {
    return [ HTTPHeader(name: NetworkHeader.contentType, value: NetworkHeader.applicationJson) ]
  }
  
  func asURLRequest() throws -> URLRequest {
    let baseURL = try baseURL.asURL()
    let url = baseURL.appendingPathComponent(path)
    
    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
    components?.queryItems = queryItems
    
    guard let finalURL = components?.url else {
      throw NetworkError.invalidURL
    }
    
    var urlRequest = try URLRequest(url: finalURL, method: method)
    
    urlRequest.allHTTPHeaderFields = headers
    urlRequest.httpBody = parameters?.data(using: .utf8)
    
    if method != .get {
      urlRequest.httpBody = body
    }
    
    return urlRequest
  }
  
}
