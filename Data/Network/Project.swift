//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 2/1/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
  name: Modules.Data.Network.rawValue,
  dependencies: [
    .external(name: "Alamofire", condition: .none)
  ]
)
