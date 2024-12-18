//
//  TargetDependency+SPM.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/19/24.
//

import ProjectDescription

public extension TargetDependency {
  enum SPM {
    static let Kingfisher     = TargetDependency.external(name: "Kingfisher") // 예시
  }
}
