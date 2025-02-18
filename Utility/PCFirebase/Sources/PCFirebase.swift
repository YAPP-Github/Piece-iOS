//
//  PCFirebase.swift
//  PCFirebase
//
//  Created by summercat on 2/16/25.
//

import FirebaseCore
import FirebaseRemoteConfig

public final class PCFirebase {
  public static let shared = PCFirebase()
  
  private var remoteConfig: RemoteConfig?
  
  private init() { }
  
  public func configureFirebaseApp() throws {
    guard let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
      let options = FirebaseOptions(contentsOfFile: filePath) else {
      throw PCFirebaseError.invalidConfiguration
    }
    
    if FirebaseApp.app() == nil {
      FirebaseApp.configure(options: options)
    }
  }
  
  public func setRemoteConfig() throws {
    guard FirebaseApp.app() != nil else {
      throw PCFirebaseError.firebaseNotInitialized
    }
    
    let remoteConfig = RemoteConfig.remoteConfig()
    let settings = RemoteConfigSettings()
    settings.minimumFetchInterval = 43_200
    remoteConfig.configSettings = settings
    
    if let path = Bundle.module.path(forResource: "remote_config_defaults", ofType: "plist"),
       let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
       let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: NSObject] {
      // plist로부터 기본값을 설정
      remoteConfig.setDefaults(plist)
    }
    self.remoteConfig = remoteConfig
  }
  
  public func fetchRemoteConfigValues() async throws {
    guard let remoteConfig = self.remoteConfig else {
      throw PCFirebaseError.remoteConfigNotInitialized
    }
    
    do {
      let status = try await remoteConfig.fetchAndActivate()
      guard status == .successFetchedFromRemote || status == .successUsingPreFetchedData else {
        throw PCFirebaseError.fetchFailed
      }
    } catch {
      throw PCFirebaseError.fetchFailed
    }
  }
  
  public func minimumVersion() -> String {
    return string(forKey: .minimumVersion)
  }
  
  public func needsForceUpdate() -> Bool {
    return bool(forKey: .needsForceUpdate)
  }
}

extension PCFirebase {
  func bool(forKey key: PCRemoteConfigKey) -> Bool {
    guard let remoteConfig else { return false }
    return remoteConfig[key.rawValue].boolValue
  }
  
  func string(forKey key: PCRemoteConfigKey) -> String {
    guard let remoteConfig else { return "" }
    return remoteConfig[key.rawValue].stringValue
  }
  
  func int(forKey key: PCRemoteConfigKey) -> Int {
    guard let remoteConfig else { return -1 }
    return remoteConfig[key.rawValue].numberValue.intValue
  }
  
  func double(forKey key: PCRemoteConfigKey) -> Double {
    guard let remoteConfig else { return -1 }
    return remoteConfig[key.rawValue].numberValue.doubleValue
  }
}
