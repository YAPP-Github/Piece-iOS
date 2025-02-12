//
//  PCUserDefaults.swift
//  LocalStorage
//
//  Created by summercat on 2/13/25.
//

import Foundation

final class PCUserDefaults {
  static func objectFor(key: UserDefaultsKeys) -> AnyObject? {
      UserDefaults.standard.object(forKey: key.rawValue) as AnyObject
  }

  static func setObjectFor(key: UserDefaultsKeys, object: Any?) -> Bool {
      if let object {
          UserDefaults.standard.set(object, forKey: key.rawValue)
      } else {
          UserDefaults.standard.removeObject(forKey: key.rawValue)
      }
      return UserDefaults.standard.synchronize()
  }
}
