//
//  Configuration+configuration.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/18/24.
//

import ProjectDescription

// TODO: - xcconfig 경로 추가
extension Configuration {
  public static func configuration(environment: AppEnvironment) -> Self {
    switch environment {
    case .dev:
      return .debug(
        name: environment.configurationName
      )
    case .prod:
      return .release(
        name: environment.configurationName
      )
    }
  }
}
