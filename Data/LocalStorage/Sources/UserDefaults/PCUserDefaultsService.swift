//
//  PCUserDefaultsService.swift
//  LocalStorage
//
//  Created by summercat on 2/13/25.
//

import Foundation

public final class PCUserDefaultsService {
  public static let shared = PCUserDefaultsService()
  
  private init() { }
  
  var didSeeOnboarding: Bool {
    get {
      PCUserDefaults.objectFor(key: .didSeeOnboarding) as? Bool ?? true
    }
    set {
      _ = PCUserDefaults.setObjectFor(key: .didSeeOnboarding, object: newValue)
    }
  }
  
  // 처음 앱을 실행하는지
  var isFirstLaunch: Bool {
    get {
      PCUserDefaults.objectFor(key: .isFirstLaunch) as? Bool ?? true
    }
    set {
      _ = PCUserDefaults.setObjectFor(key: .isFirstLaunch, object: newValue)
    }
  }
}

public extension PCUserDefaultsService {
  // 로그아웃 시 UserDefaults 초기화 메서드
  func initialize() {
    didSeeOnboarding = false
  }
  
  func getDidSeeOnboarding() -> Bool {
    didSeeOnboarding
  }
  
  func setDidSeeOnboarding(_ didSeeOnboarding: Bool) {
    self.didSeeOnboarding = didSeeOnboarding
  }

  /// 첫 실행 여부 확인
  func checkFirstLaunch() -> Bool {
    if isFirstLaunch {
      isFirstLaunch = false
      return true
    }
    return false
  }
  
  // 강제로 첫 실행 플래그를 리셋 (테스트용)
  func resetFirstLaunch() {
    isFirstLaunch = true
    didSeeOnboarding = false
  }
}
