//
//  ExternalDependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 2/8/25.
//

import ProjectDescription

public enum ExternalDependencies {
  case Alamofire
  
  public var name: String {
    switch self {
    case .Alamofire: "Alamofire"
    }
  }
}
