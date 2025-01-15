// swift-tools-version: 6.0
import PackageDescription

#if TUIST
import struct ProjectDescription.PackageSettings
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
  // Customize the product types for specific package product
  // Default is .staticFramework
  // productTypes: ["Alamofire": .framework,]
  productTypes: [:],
  baseSettings: .settings()
//      .settings(
//    configurations: [
//      .configuration(environment: .dev),
//      .configuration(environment: .prod),
//    ])
)
#endif

let package = Package(
  name: "Piece-iOS",
  dependencies:
    ExternalDependency.allCases.map {
      Package.Dependency.package(
        url: $0.url,
        from: $0.version
      )
    }
)

enum ExternalDependency: String, CaseIterable {
  case SwiftNavigation
}

extension ExternalDependency {
  var url: String {
    switch self {
    case .SwiftNavigation: "https://github.com/pointfreeco/swift-navigation"
    }
  }
}

extension ExternalDependency {
  var version: PackageDescription.Version {
    switch self {
    case .SwiftNavigation: "2.0.0"
    }
  }
}
