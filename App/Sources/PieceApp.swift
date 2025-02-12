import DesignSystem
import Router
import KakaoSDKCommon
import GoogleSignIn
import SwiftUI

@main
struct PieceApp: App {
 
  init() {
    // Kakao SDK 초기화
    KakaoSDK.initSDK(appKey: "NATIVE_APP_KEY")
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .preventScreenshot() 
        .onOpenURL { url in
          GIDSignIn.sharedInstance.handle(url)
        }
        .onAppear {
          GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            // Check if `user` exists; otherwise, do something with `error`
          }
        }
    }
  }
}
