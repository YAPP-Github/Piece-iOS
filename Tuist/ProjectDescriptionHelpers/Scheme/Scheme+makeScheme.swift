//
//  Scheme+makeScheme.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/18/24.
//

import ProjectDescription

extension Scheme {
  public static func makeScheme(/*environment: AppEnvironment*/) -> Scheme {
    return .scheme(
      name: "\(AppConstants.appName)"/*-\(environment.rawValue)*/,
      buildAction: .buildAction(targets: ["\(AppConstants.appName)"]),
      runAction: .runAction(configuration: "Debug"),// environment.configurationName),
      archiveAction: .archiveAction(configuration: "Release"), //environment.configurationName),
      profileAction: .profileAction(configuration: "Release"), //environment.configurationName),
      analyzeAction: .analyzeAction(configuration: "Debug") //environment.configurationName)
    )
  }
}
