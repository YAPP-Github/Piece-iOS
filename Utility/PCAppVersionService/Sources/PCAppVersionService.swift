//
//  PCAppVersionService.swift
//  PCAppVersionService
//
//  Created by summercat on 2/16/25.
//

import Foundation
import PCRemoteConfig

public final class PCAppVersionService {
  private let remoteConfig: PCRemoteConfig
  
  public init(remoteConfig: PCRemoteConfig = .shared) {
    self.remoteConfig = remoteConfig
  }
  
  public func appVersion() -> String? {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
  }
  
  public func needsForceUpdate() async throws -> Bool {
    guard let currentVersion = appVersion(),
          let minimumVersion = try await remoteConfig.appVersion(),
          let needsForceUpdate = try await remoteConfig.needsForceUpdate() else {
      return false
    }
    
    return needsForceUpdate && currentVersion.compare(minimumVersion, options: .numeric) == .orderedAscending
  }
}
