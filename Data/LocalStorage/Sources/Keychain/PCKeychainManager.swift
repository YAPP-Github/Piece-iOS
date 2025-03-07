//
//  PCKeychainManager.swift
//  LocalStorage
//
//  Created by eunseou on 2/2/25.
//

import Foundation

public class PCKeychainManager {
  public static let shared = PCKeychainManager()
  
  public init() { }
  
  public func save(_ key: PCKeychain, value: String) {
    guard let data = value.data(using: .utf8) else {
      return
    }
    
    let query: NSDictionary = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: key.rawValue,
      kSecAttrService: key.rawValue,
      kSecValueData: data
    ]
    
    SecItemDelete(query)
    SecItemAdd(query, nil)
  }
  
  public func read(_ key: PCKeychain) -> String? {
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
  
  public func delete(_ key: PCKeychain) {
    let query: NSDictionary = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: key.rawValue,
      kSecAttrService: key.rawValue
    ]
    
    SecItemDelete(query)
  }
  
  public func deleteAll() {
    PCKeychain.allCases.forEach { delete($0) }
  }
}
