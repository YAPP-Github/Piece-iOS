//
//  ProfileEndpoint.swift
//  PCNetwork
//
//  Created by summercat on 2/9/25.
// 

import Alamofire
import DTO
import Foundation

public enum ProfileEndpoint: TargetType {
  case postProfile(PostProfileRequestDTO)
  case postCheckNickname(String)
  case postUploadImage(Data)
  case getValuePicks
  case updateValuePicks([ValuePickRequestDTO])
  case postCheckNickname(String)
  case postUploadImage(Data)
  
  public var method: HTTPMethod {
    switch self {
    case .postProfile: .post
    case .postCheckNickname: .post
    case .postUploadImage: .post
    case .getValuePicks: .get
    case .updateValuePicks: .put
    case .postCheckNickname: .post
    case .postUploadImage: .post
    }
  }
  
  public var path: String {
    switch self {
    case .postProfile: "api/profiles"
    case .postCheckNickname: "api/profiles/check-nickname"
    case .postUploadImage: "api/profiles/images"
    case .getValuePicks: "api/profiles/valuePicks"
    case .updateValuePicks: "api/profiles/valuePicks"
    case .postCheckNickname: "api/profiles/check-nickname"
    case .postUploadImage: "api/profiles/images"
    }
  }
  
  public var headers: [String : String] {
    switch self {
    case .postProfile: [:]
    case .postCheckNickname: [NetworkHeader.accept : NetworkHeader.all]
    case .postUploadImage: [NetworkHeader.contentType : NetworkHeader.multipartFormData]
    case .getValuePicks: [:]
    case .updateValuePicks: [:]
    case .postCheckNickname: [NetworkHeader.accept : NetworkHeader.all]
    case .postUploadImage: [NetworkHeader.contentType : NetworkHeader.multipartFormData]
    }
  }
  
  public var requestType: RequestType {
    switch self {
    case let .postProfile(dto): .body(dto)
    case let .postCheckNickname(string): .query([URLQueryItem(name: "nickname", value: string)])
    case let .postUploadImage(data): .multipart(data)
    case .getValuePicks: .plain
    case let .updateValuePicks(dto): .body(dto)
    case let .postCheckNickname(string): .query([URLQueryItem(name: "nickname", value: string)])
    case let .postUploadImage(data): .multipart(data)
    }
  }
}
