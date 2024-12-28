//
//  Project+staticLibrary.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/16/24.
//

import ProjectDescription

extension Project {
  public static func staticLibrary(
    name: String,
    infoPlist: InfoPlist? = .default,
    dependencies: [TargetDependency] = [],
    packages: [Package] = []
  ) -> Project {
    let target = Target.target(
      name: name,
      destinations: AppConstants.destinations,
      product: .staticLibrary,
      bundleId: "\(AppConstants.organizationName).\(name)",
      deploymentTargets: AppConstants.deploymentTargets,
      infoPlist: infoPlist,
      sources: ["Sources/**"],
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
