//
//  Contants.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/16/24.
//

import ProjectDescription

public enum Constants {
  public static let appName: String = "Piece-iOS"
  public static let organizationName: String = "puzzle" // 추후 수정 필요
  public static let version: Plist.Value = "1.0.0"
  public static let build: Plist.Value = "1"
  public static let destinations: Set<Destination> = .iOS
  public static let deploymentTargets: DeploymentTargets = .iOS("16.0") // 논의 필요
}
