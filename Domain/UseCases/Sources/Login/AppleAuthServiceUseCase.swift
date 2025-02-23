//
//  AppleAuthService.swift
//  UseCases
//
//  Created by eunseou on 2/22/25.
//

import SwiftUI
import AuthenticationServices
import Entities

public protocol AppleAuthServiceUseCase {
  func execute() async throws -> AppleAuthResultModel
}

public final class AppleAuthServiceUseCaseImpl: NSObject, AppleAuthServiceUseCase {
  private var continuation: CheckedContinuation<AppleAuthResultModel, Error>?
  
  public func execute() async throws -> AppleAuthResultModel {
    return try await withCheckedThrowingContinuation { continuation in
      self.continuation = continuation
      let request = ASAuthorizationAppleIDProvider().createRequest()
      request.requestedScopes = [.fullName, .email]
      
      let controller = ASAuthorizationController(authorizationRequests: [request])
      controller.delegate = self
      controller.performRequests()
    }
  }
}

extension AppleAuthServiceUseCaseImpl: ASAuthorizationControllerDelegate {
  public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
          let authorizationCodeData = appleIDCredential.authorizationCode,
          let authorizationCode = String(data: authorizationCodeData, encoding: .utf8)
    else {
      continuation?.resume(throwing: NSError(domain: "AppleAuth", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid Credential"]))
      return
    }
    
    let result = AppleAuthResultModel(
      authorizationCode: authorizationCode,
      fullName: appleIDCredential.fullName,
      email: appleIDCredential.email
    )
    continuation?.resume(returning: result)
  }
  
  public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    continuation?.resume(throwing: error)
  }
}
