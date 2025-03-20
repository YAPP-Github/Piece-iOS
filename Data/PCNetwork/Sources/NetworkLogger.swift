//
//  NetworkLogger.swift
//  PCNetwork
//
//  Created by summercat on 3/20/25.
//

import Alamofire
import Foundation
import PCFoundationExtension

final class NetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "NetworkLogger")

    func requestDidFinish(_ request: Request) {
      print("🛰 NETWORK Reqeust LOG")
      print(request.description)

      print(
        "🛰 URL: " + (request.request?.url?.absoluteString ?? "")  + "\n"
          + "🛰 Method: " + (request.request?.httpMethod ?? "") + "\n"
          + "🛰 Headers: " + "\(request.request?.allHTTPHeaderFields ?? [:])" + "\n"
      )
      print("🛰 Authorization: " + (request.request?.headers["Authorization"] ?? ""))
      print("🛰 Body: " + (request.request?.httpBody?.toPrettyPrintedString ?? ""))
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("🛰 NETWORK Response LOG")
        print(
          "🛰 URL: " + (request.request?.url?.absoluteString ?? "") + "\n"
            + "🛰 Result: " + "\(response.result)" + "\n"
            + "🛰 StatusCode: " + "\(response.response?.statusCode ?? 0)" + "\n"
            + "🛰 Data: \(response.data?.toPrettyPrintedString ?? "")"
        )
    }
}
