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
    let name = AppConstants.appName
    let target = Target.target(
      name: AppConstants.appName,
      destinations: AppConstants.destinations,
      product: .app,
      bundleId: AppConstants.bundleId,
      deploymentTargets: AppConstants.deploymentTargets,
      infoPlist: .default,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: dependencies,
      settings: .settings()
//          .settings(
//        configurations: [
//          .configuration(environment: .dev),
//          .configuration(environment: .prod),
//        ]
//      )
      ,
      environmentVariables: [:],
      additionalFiles: []
    )
    
    return Project(
      name: name,
      organizationName: AppConstants.organizationName,
      options: .options(
        automaticSchemesOptions: .disabled,
        developmentRegion: "kor"
      ),
      packages: [],
      settings: .settings(),
//          .settings(configurations: [
//        .configuration(environment: .dev),
//        .configuration(environment: .prod),
//      ]),
      targets: [target],
      schemes: [
        .makeScheme(),
//        .makeScheme(environment: .dev),
//        .makeScheme(environment: .prod),
      ]
    )
  }
}
