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
  
  public var blockContactsLastUpdatedDate: Date? {
    get {
      PCUserDefaults.objectFor(key: .blockContactsLastUpdatedDate) as? Date
    }
    set {
      _ = PCUserDefaults.setObjectFor(key: .blockContactsLastUpdatedDate, object: newValue)
    }
  }
}

public extension PCUserDefaultsService {
  // 로그아웃 시 UserDefaults 초기화 메서드
  func initialize() {
    blockContactsLastUpdatedDate = nil
  }
  
  func getBlockContactsLastUpdatedDate() -> Date? {
    blockContactsLastUpdatedDate
  }
  
  func setBlockContactsLastUpdatedDate(_ date: Date) {
    self.blockContactsLastUpdatedDate = date
  }
}
