import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
  dependencies: [
    .presentation(target: .AppCoordinator),
  ]
)
