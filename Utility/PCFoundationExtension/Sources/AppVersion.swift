//
//  AppVersion.swift
//  PCFoundationExtension
//
//  Created by summercat on 2/18/25.
//

import Foundation

public final class AppVersion {
  public static func appVersion() -> String {
    guard let dictionary = Bundle.main.infoDictionary,
          let version = dictionary["CFBundleShortVersionString"] as? String else {
      return ""
    }

    return version
  }
}
