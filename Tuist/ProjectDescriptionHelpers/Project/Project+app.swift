//
//  Project+app.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/16/24.
//

import ProjectDescription

extension Project {
  public static func app(
    dependencies: [TargetDependency] = []
  ) -> Project {
    let name = Constants.appName
    let target = Target.target(
      name: Constants.appName,
      destinations: Constants.destinations,
      product: .app,
      bundleId: "\(Constants.organizationName).\(name)",
      deploymentTargets: Constants.deploymentTargets,
      infoPlist: .default,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: dependencies,
      settings: .settings(
        configurations: [
          .configuration(environment: .dev),
          .configuration(environment: .prod),
        ]
      ),
      environmentVariables: [:],
      additionalFiles: []
    )
    
    return Project(
      name: name,
      organizationName: Constants.organizationName,
      options: .options(
        automaticSchemesOptions: .disabled,
        developmentRegion: "kor"
      ),
      packages: [],
      settings: .settings(configurations: [
        .configuration(environment: .dev),
        .configuration(environment: .prod),
      ]),
      targets: [target],
      schemes: [
        .makeScheme(environment: .dev),
        .makeScheme(environment: .prod),
      ]
    )
  }
}