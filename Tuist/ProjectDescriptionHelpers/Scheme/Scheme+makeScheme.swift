//
//  Scheme+makeScheme.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/18/24.
//

import ProjectDescription

extension Scheme {
  public static func makeScheme(environment: AppEnvironment) -> Scheme {
    return .scheme(
      name: "\(Constants.appName)-\(environment.rawValue)",
      buildAction: .buildAction(targets: ["\(Constants.appName)"]),
      runAction: .runAction(configuration: environment.configurationName),
      archiveAction: .archiveAction(configuration: environment.configurationName),
      profileAction: .profileAction(configuration: environment.configurationName),
      analyzeAction: .analyzeAction(configuration: environment.configurationName)
    )
  }
}
