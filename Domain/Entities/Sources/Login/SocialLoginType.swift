//
//  SocialLoginType.swift
//  Entities
//
//  Created by summercat on 4/16/25.
//

public enum SocialLoginType: String, Encodable {
  case apple
  case kakao
  case google
}

public extension SocialLoginType {
  var description: String {
    switch self {
    case .apple: "애플"
    case .kakao: "카카오"
    case .google: "구글"
    }
  }
}
