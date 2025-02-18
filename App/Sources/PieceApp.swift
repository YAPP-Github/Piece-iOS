import DesignSystem
import PCFirebase
import Router
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

@main
struct PieceApp: App {
  init() {
    do {
      try PCFirebase.shared.configureFirebaseApp()
      try PCFirebase.shared.setRemoteConfig()
    } catch let error as PCFirebaseError {
      print("Firebase setup failed: \(error.errorDescription)")
    } catch {
      print("Firebase setup failed with unknown error:", error)
    }
    
    // Kakao SDK 초기화
    guard let kakaoAppKey = Bundle.main.infoDictionary?["NATIVE_APP_KEY"] as? String else {
      print("Failed to load Kakao App Key")
      return
    }
    KakaoSDK.initSDK(appKey: kakaoAppKey)
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .preventScreenshot()
        .onOpenURL(perform: { url in
          if (AuthApi.isKakaoTalkLoginUrl(url)) {
            AuthController.handleOpenUrl(url: url)
          }
        })
        .onOpenURL { url in
          GIDSignIn.sharedInstance.handle(url)
        }
    }
  }
}
