//
//  PCUserDefaultsService.swift
//  LocalStorage
//
//  Created by summercat on 2/13/25.
//

import Foundation

public protocol PCUserDefaultsService {
  func getIsBlockContactsEnabled() -> Bool
  func setIsBlockContactsEnabled(_ enabled: Bool)
  
  func getBlockContactsLastUpdatedDate() -> Date?
  func setBlockContactsLastUpdatedDate(_ date: Date)
}

public final class PCUserDefaultsServiceImpl {
  public static let shared = PCUserDefaultsServiceImpl()
  
  private init() { }

  public var isBlockContactsEnabled: Bool {
    get {
      PCUserDefaults.objectFor(key: .isBlockContactsEnabled) as? Bool ?? false
    }
    set {
      _ = PCUserDefaults.setObjectFor(key: .isBlockContactsEnabled, object: newValue)
    }
  }
  
  public var blockContactsLastUpdatedDate: Date? {
    get {
      PCUserDefaults.objectFor(key: .blockContactsLastUpdatedDate) as? Date
    }
    set {
      _ = PCUserDefaults.setObjectFor(key: .blockContactsLastUpdatedDate, object: newValue)
    }
  }
}

extension PCUserDefaultsServiceImpl: PCUserDefaultsService {
  public func getIsBlockContactsEnabled() -> Bool {
    isBlockContactsEnabled
  }
  
  public func setIsBlockContactsEnabled(_ enabled: Bool) {
    self.isBlockContactsEnabled = enabled
  }
  
  public func getBlockContactsLastUpdatedDate() -> Date? {
    blockContactsLastUpdatedDate
  }
  
  public func setBlockContactsLastUpdatedDate(_ date: Date) {
    self.blockContactsLastUpdatedDate = date
  }
}
