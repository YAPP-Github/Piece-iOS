//
//  feature.swift
//  AppManifests
//
//  Created by summercat on 1/2/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let nameAttribute: Template.Attribute = .required("name")
private let yearAttribute: Template.Attribute = .optional("year", default: .defaultYear)
private let dateAttribute: Template.Attribute = .optional("date", default: .defaultDate)
private let authorAttribute: Template.Attribute = .optional("author", default: .defaultAuthor)

let featureTemplate = Template(
    description: "presentation 레이어의 feature 모듈 생성",
    attributes: [
        nameAttribute,
        yearAttribute,
        dateAttribute,
        authorAttribute,
    ],
    items: [
        .file(
            path: "Presentation/Feature/\(nameAttribute)/Project.swift",
            templatePath: "Project.stencil"),
        .file(
            path: "Presentation/Feature/\(nameAttribute)/Sources/\(nameAttribute)View.swift",
            templatePath: "View.stencil"),
        .file(
            path: "Presentation/Feature/\(nameAttribute)/Sources/\(nameAttribute)ViewModel.swift",
            templatePath: "ViewModel.stencil"),
    ]
)
