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
    dependencies: [TargetDependency] = [],
    packages: [Package] = []
  ) -> Project {
    let target = Target.target(
      name: name,
      destinations: Constants.destinations,
      product: .staticLibrary,
      bundleId: "\(Constants.organizationName).\(name)",
      deploymentTargets: Constants.deploymentTargets,
      sources: ["Sources/**"],
      dependencies: dependencies
    )
    
    return Project(
      name: name,
      packages: packages,
      targets: [target]
    )
  }
}
