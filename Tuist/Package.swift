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
  case Kingfisher
  case Alamofire
}

extension ExternalDependency {
  var url: String {
    switch self {
    case .Kingfisher: "https://github.com/onevcat/Kingfisher"
    case .Alamofire: "https://github.com/Alamofire/Alamofire"
    }
  }
}

extension ExternalDependency {
  var version: PackageDescription.Version {
    switch self {
    case .Kingfisher: "8.1.4"
    case .Alamofire: "5.10.2"
    }
  }
}
