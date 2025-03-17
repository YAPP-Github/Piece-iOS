//
//  OAuthCredential.swift
//  PCNetwork
//
//  Created by summercat on 3/17/25.
//

import Alamofire
import Foundation

struct OAuthCredential: AuthenticationCredential {
  let accessToken: String
  let refreshToken: String
  let expiration: Date

  // Require refresh if within 24H of expiration
  var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 60) > expiration }
}
