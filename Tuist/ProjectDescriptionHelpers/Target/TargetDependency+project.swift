//
//  TargetDependency+project.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/18/24.
//

import ProjectDescription

public extension TargetDependency {
  static func data(target: Modules.Data) -> TargetDependency {
    .project(
      target: target.targetName,
      path: .relativeToRoot(target.path)
    )
  }
  
  static func domain(target: Modules.Domain) -> TargetDependency {
    .project(
      target: target.targetName,
      path: .relativeToRoot(target.path)
    )
  }
  
  static func presentation(target: Modules.Presentation) -> TargetDependency {
    .project(
      target: target.targetName,
      path: .relativeToRoot(target.path)
    )
  }
}
