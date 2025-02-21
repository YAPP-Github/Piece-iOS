//
//  Project.swift
//
//  Created by summercat on 12/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
  name: Modules.Presentation.Router.rawValue,
  dependencies: [
    .domain(target: .Entities),
  ]
)
