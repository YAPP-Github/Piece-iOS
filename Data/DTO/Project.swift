//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 2/3/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
  name: Modules.Data.DTO.rawValue,
  dependencies: [
    .domain(target: .Entities)
  ]
)
