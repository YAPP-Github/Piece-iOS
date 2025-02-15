//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 1/10/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticLibrary(
  name: Modules.Presentation.Login.rawValue,
  dependencies: [
    .presentation(target: .DesignSystem),
    .utility(target: .PCFoundationExtension),
    .domain(target: .UseCases),
    .presentation(target: .Router),
    .externalDependency(dependency: .KakaoSDKAuth),
    .externalDependency(dependency: .KakaoSDKUser),
  ]
)
