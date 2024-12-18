// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [:]
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
  case Kingfisher // 예시
}

extension ExternalDependency {
  var url: String {
    switch self {
    case .Kingfisher: "https://github.com/onevcat/Kingfisher.git"
    }
  }
}

extension ExternalDependency {
  var version: PackageDescription.Version {
    switch self {
    case .Kingfisher: "7.0.0"
    }
  }
}
