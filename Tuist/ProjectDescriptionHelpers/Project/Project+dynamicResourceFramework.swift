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
    dependencies: [TargetDependency] = [],
    packages: [Package] = []
  ) -> Project {
    let target = Target.target(
      name: name,
      destinations: Constants.destinations,
      product: .framework,
      bundleId: "\(Constants.organizationName).\(name)",
      deploymentTargets: Constants.deploymentTargets,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: dependencies
    )
    
    return Project(
      name: name,
      packages: packages,
      targets: [target]
    )
  }
}
