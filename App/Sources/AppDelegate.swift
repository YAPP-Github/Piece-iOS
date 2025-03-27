//
//  AppDelegate.swift
//  Piece-iOS
//
//  Created by summercat on 2/22/25.
//  Copyright © 2025 puzzly. All rights reserved.
//

import PCFirebase
import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    do {
      print("🔥 Configure FirebaseApp")
      try PCFirebase.shared.configureFirebaseApp()
    } catch let error as PCFirebaseError {
      print("Firebase setup failed: \(error.errorDescription)")
    } catch {
      print("Firebase setup failed with unknown error:", error)
    }
    
    do {
      print("🔥 Firebase RemoteConfig setRemoteConfig")
      try PCFirebase.shared.setRemoteConfig()
    } catch let error as PCFirebaseError {
      print("Firebase setup failed: \(error.errorDescription)")
    } catch {
      print("Firebase setup failed with unknown error:", error)
    }
    
    // MARK: - Firebase Cloud Messaging (푸시알림)
    PCNotificationService.shared.setDelegate()
    PCNotificationService.shared.enableAutoInit()
    PCNotificationService.shared.requestPushPermission()
    
    return true
  }
  
  // 앱이 종료된 상태에서 푸시 알림을 받았을 때 호출되는 메소드
  func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable : Any]
  ) async -> UIBackgroundFetchResult {
    return .newData
  }
  
  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    print("앱이 APNs에 성공적으로 등록" )
    PCNotificationService.shared.setApnsToken(deviceToken)
  }
}
