import DesignSystem
import FirebaseCore
import FirebaseRemoteConfig
import LocalStorage
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
    
    // 앱 첫 실행 테스트 시, 아래 주석 해제
    // PCUserDefaultsService.shared.resetFirstLaunch()
    if PCUserDefaultsService.shared.checkFirstLaunch() {
      PCUserDefaultsService.shared.initialize()
      PCUserDefaultsService.shared.setDidSeeOnboarding(false)
      PCKeychainManager.shared.deleteAll()
    }
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
