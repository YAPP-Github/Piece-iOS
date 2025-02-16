//
//  PCRemoteConfig.swift
//  PCRemoteConfig
//
//  Created by summercat on 2/16/25.
//

import FirebaseRemoteConfig

public final class PCRemoteConfig {
  public static let shared = PCRemoteConfig()
  
  private let remoteConfig = RemoteConfig.remoteConfig()
  
  private init() {
    let settings = RemoteConfigSettings()
    settings.minimumFetchInterval = 0
    remoteConfig.configSettings = settings
  }
  
  public func appVersion() async throws -> String? {
    do {
      let status = try await remoteConfig.fetch()
      guard status == .success else { return nil }
      try await remoteConfig.activate()
      return remoteConfig[PCRemoteConfigKey.minimumVersion.rawValue].stringValue
    } catch {
      throw error
    }
  }
  
  public func needsForceUpdate() async throws -> Bool? {
    do {
      let status = try await remoteConfig.fetch()
      guard status == .success else { return nil }
      try await remoteConfig.activate()
      return remoteConfig[PCRemoteConfigKey.needsForceUpdate.rawValue].boolValue
    } catch {
      throw error
    }
  }
}
