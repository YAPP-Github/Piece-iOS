import ProjectDescription

let project = Project(
    name: "Piece-iOS",
    targets: [
        .target(
            name: "Piece-iOS",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.Piece-iOS",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Piece-iOS/Sources/**"],
            resources: ["Piece-iOS/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "Piece-iOSTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.Piece-iOSTests",
            infoPlist: .default,
            sources: ["Piece-iOS/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Piece-iOS")]
        ),
    ]
)
