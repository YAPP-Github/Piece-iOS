//
//  Project+dynamicResourceFramework.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/18/24.
//

import ProjectDescription

extension Project {
  public static func dynamicResourceFramework(
    name: String,
    infoPlist: InfoPlist? = .default,
    dependencies: [TargetDependency] = [],
    packages: [Package] = []
  ) -> Project {
    let target = Target.target(
      name: name,
      destinations: AppConstants.destinations,
      product: .framework,
      bundleId: "\(AppConstants.organizationName).\(name)",
      deploymentTargets: AppConstants.deploymentTargets,
      infoPlist: infoPlist,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: dependencies
    )
    
    return Project(
      name: name,
      packages: packages,
      settings: .settings(
        configurations: [
          .configuration(environment: .dev),
          .configuration(environment: .prod),
        ]
      ),
      targets: [target]
    )
  }
}
