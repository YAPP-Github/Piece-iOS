//
//  Project.swift
//
//  Created by summercat on 12/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
  name: Modules.Presentation.Coordinator.rawValue,
  dependencies: [
    .domain(target: .UseCases),
    .data(target: .PCNetwork),
    .data(target: .Repository),
    .presentation(target: .Router),
    .presentation(target: .Home),
    .presentation(target: .Profile),
    .presentation(target: .Settings),
    .presentation(target: .MatchingDetail),
    .presentation(target: .SignUp),
    .presentation(target: .EditValuePick),
    .presentation(target: .Login)
  ]
)
