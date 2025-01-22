//
//  Project+app.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/16/24.
//

import ProjectDescription

extension Project {
  public static func app(
    dependencies: [TargetDependency] = [],
    packages: [Package] = []
  ) -> Project {
    let name = AppConstants.appName
    let target = Target.target(
      name: AppConstants.appName,
      destinations: AppConstants.destinations,
      product: .app,
      bundleId: AppConstants.bundleId,
      deploymentTargets: AppConstants.deploymentTargets,
      infoPlist: .extendingDefault(with: [
        "UILaunchScreen": "LaunchScreen",
        "NSCameraUsageDescription": "프로필 생성 시 사진 첨부를 위해 카메라 접근 권한이 필요합니다.",
        "NSContactsUsageDescription": "지인을 수집하기 위해 연락처 접근 권한이 필요합니다."
      ]),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: dependencies,
      settings: .settings()
//          .settings(
//        configurations: [
//          .configuration(environment: .dev),
//          .configuration(environment: .prod),
//        ]
//      )
      ,
      environmentVariables: [:],
      additionalFiles: []
    )
    
    return Project(
      name: name,
      organizationName: AppConstants.organizationName,
      options: .options(
        automaticSchemesOptions: .disabled,
        developmentRegion: "kor"
      ),
      packages: packages,
      settings: .settings(),
//          .settings(configurations: [
//        .configuration(environment: .dev),
//        .configuration(environment: .prod),
//      ]),
      targets: [target],
      schemes: [
        .makeScheme(),
//        .makeScheme(environment: .dev),
//        .makeScheme(environment: .prod),
      ]
    )
  }
}
