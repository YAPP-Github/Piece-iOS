//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 2/2/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
  name: Modules.Domain.RepositoryInterfaces.rawValue,
  dependencies: [
    .domain(target: .Entities)
  ]
)
