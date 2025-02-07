//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 2/1/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
  name: Modules.Data.PCNetwork.rawValue,
  infoPlist: .extendingDefault(with: [
    "BASE_URL": "$(BASE_URL)"
  ]),
  dependencies: [
    .externalDependency(dependency: .Alamofire),
    .data(target: .LocalStorage),
    .data(target: .DTO),
    .external(name: "Alamofire", condition: .none),
    .external(name:"KakaoSDKCommon", condition: .none),
    .external(name:"KakaoSDKAuth", condition: .none),
    .external(name:"KakaoSDKUser", condition: .none)
  ]
)
