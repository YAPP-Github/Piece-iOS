//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 2025/01/30.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
  name: Modules.Domain.UseCases.rawValue,
  dependencies: [
    .domain(target: .Entities),
    .data(target: .Repository)
  ]
)
