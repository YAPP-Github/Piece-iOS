//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 1/7/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicResourceFramework(
  name: Modules.Utility.PCFirebase.rawValue,
  dependencies: [
    .data(target: .PCNetwork),
    .data(target: .Repository),
    .domain(target: .UseCases),
    .externalDependency(dependency: .FirebaseAnalytics),
    .externalDependency(dependency: .FirebaseCore),
    .externalDependency(dependency: .FirebaseMessaging),
    .externalDependency(dependency: .FirebaseRemoteConfig),
  ],
  settings: .settings(
    base: [
      "OTHER_LDFLAGS": ["-ObjC"]
    ]
  )
)
