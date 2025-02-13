////
////  GoogleLoginService.swift
////  Login
////
////  Created by eunseou on 2/13/25.
////
//
//import SwiftUI
//import GoogleSignIn
//import GoogleSignInSwift
//
//final class GoogleAuthService {
//  static let shared = GoogleAuthService()
//  
//  // Google 로그인 메서드
//  func signIn(completion: @escaping (Result<String, Error>) -> Void) {
//    guard let clientID = Bundle.main.infoDictionary?["GIDClientID"] as? String else {
//      completion(.failure(NSError(domain: "GoogleSignIn", code: -1, userInfo: [NSLocalizedDescriptionKey: "Google Client ID not found"])))
//      return
//    }
//    
//    let config = GIDConfiguration(clientID: clientID)
//    
//    // 앱의 최상위 뷰컨트롤러 찾기
//    guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
//      completion(.failure(NSError(domain: "GoogleSignIn", code: -1, userInfo: [NSLocalizedDescriptionKey: "Root ViewController not found"])))
//      return
//    }
//    
//    // Google 로그인 수행
//    GIDSignIn.sharedInstance.signIn(with: config, withPresenting: rootViewController) { user, error in
//      if let error = error {
//        completion(.failure(error))
//        return
//      }
//      
//      guard let user = user, let idToken = user.idToken?.tokenString else {
//        completion(.failure(NSError(domain: "GoogleSignIn", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get ID token"])))
//        return
//      }
//      
//      completion(.success(idToken))
//    }
//  }
//}
