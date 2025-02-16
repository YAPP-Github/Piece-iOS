//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 1/7/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
  name: Modules.Utility.PCRemoteConfig.rawValue,
  dependencies: [
    .externalDependency(dependency: .FirebaseRemoteConfig),
  ]
)
