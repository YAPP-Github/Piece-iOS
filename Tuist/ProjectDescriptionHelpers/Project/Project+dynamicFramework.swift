//
//  Project+dynamicFramework.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/16/24.
//

import ProjectDescription

extension Project {
  public static func dynamicFramework(
    name: String,
    dependencies: [TargetDependency] = [],
    packages: [Package] = [],
    mergedBinaryType: MergedBinaryType = .disabled,
    mergeable: Bool = false
  ) -> Project {
    let target = Target.target(
      name: name,
      destinations: AppConstants.destinations,
      product: .framework,
      bundleId: "\(AppConstants.organizationName).\(name)",
      deploymentTargets: AppConstants.deploymentTargets,
      sources: ["Sources/**"],
      dependencies: dependencies,
      mergedBinaryType: mergedBinaryType,
      mergeable: mergeable
    )
    
    return Project(
      name: name,
      packages: packages,
      targets: [target]
    )
  }
}
