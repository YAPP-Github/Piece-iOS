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
      infoPlist: .extendingDefault(
        with: [
          "UILaunchStoryboardName": "LaunchScreen",
          "NSCameraUsageDescription": "프로필 생성 시 사진 첨부를 위해 카메라 접근 권한이 필요합니다.",
          "NSPhotoLibraryUsageDescription": "프로필 생성 시 사진 첨부를 위해 앨범 접근 권한이 필요합니다.",
          "NSContactsUsageDescription": "사용자가 원할 경우, 사용자의 연락처에 있는 상대에게 사용자가 노출되지 않도록 하기 위해 연락처 정보를 수집합니다.",
          "BASE_URL": "$(BASE_URL)",
          "NATIVE_APP_KEY": "$(NATIVE_APP_KEY)",
          "NSAppTransportSecurity": [
            "NSAllowsArbitraryLoads": true
          ],
          "LSApplicationQueriesSchemes": [
            "kakaokompassauth"
          ],
          "GIDClientID": "$(GIDClientID)",
          "CFBundleURLSchemes": [
            "CFBundleURLSchemes": [
              "kakao$(NATIVE_APP_KEY)",
              "YOUR_DOT_REVERSED_IOS_CLIENT_ID"
            ]
          ]
        ]
      ),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      entitlements: .file(path: .relativeToRoot("Piece-iOS.entitlements")),
      dependencies: dependencies,
      settings: .settings(
        base: [
          "OTHER_LDFLAGS": ["-ObjC"]
        ],
        configurations: [
          .debug(name: "Debug", xcconfig: .relativeToRoot("Config.xcconfig")),
          .release(name: "Release", xcconfig: .relativeToRoot("Config.xcconfig"))
        ]
      )
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
