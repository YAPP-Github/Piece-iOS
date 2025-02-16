import DesignSystem
import FirebaseCore
import FirebaseRemoteConfig
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
    // Kakao SDK 초기화
    guard let KakaoAppKey = Bundle.main.infoDictionary?["NATIVE_APP_KEY"] as? String else {
      fatalError()
    }
    KakaoSDK.initSDK(appKey: KakaoAppKey)
    FirebaseApp.configure()
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
