//
//  KeychainManager.swift
//  LocalStorage
//
//  Created by eunseou on 2/2/25.
//

import Foundation

public class KeychainManager {
  public static let shared = KeychainManager()
  
  public init() { }
  
  public func save(_ key: Keychain, value: String) {
    guard let data = value.data(using: .utf8) else {
      return
    }
    
    let query: NSDictionary = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: key.rawValue,
      kSecValueData: data
    ]
    
    SecItemDelete(query)
    SecItemAdd(query, nil)
  }
  
  public func read(_ key: Keychain) -> String? {
    let query: NSDictionary = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: key.rawValue,
      kSecAttrService: key.rawValue,
      kSecReturnData: true,
      kSecMatchLimit: kSecMatchLimitOne
    ]
    
    var result: AnyObject?
    let status = SecItemCopyMatching(query, &result)
    
    guard status == errSecSuccess,
          let data = result as? Data,
          let value = String(data: data, encoding: .utf8) else {
      return nil
    }
    
    return value
  }
  
  public func delete(_ key: Keychain) {
    let query: NSDictionary = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: key.rawValue,
      kSecAttrService: key.rawValue
    ]
    
    SecItemDelete(query)
  }
  
  public func deleteAll() {
    Keychain.allCases.forEach { delete($0) }
  }
}
