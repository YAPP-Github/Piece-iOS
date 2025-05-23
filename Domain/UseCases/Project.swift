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
    .domain(target: .RepositoryInterfaces),
    .data(target: .LocalStorage),
  ]
)
