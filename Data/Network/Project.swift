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
  infoPlist: .extendingDefault(with: [
    "BASE_URL": "$(BASE_URL)"
  ]),
  dependencies: [
    .external(name: "Alamofire", condition: .none),
    .data(target: .LocalStorage)
  ]
)
