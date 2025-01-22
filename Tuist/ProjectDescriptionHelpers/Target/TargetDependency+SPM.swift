//
//  TargetDependency+SPM.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/19/24.
//

import ProjectDescription

public extension TargetDependency {
  public enum SPM {
    public static let SwiftNavigation      = TargetDependency.external(name: "SwiftNavigation")
  }
}
