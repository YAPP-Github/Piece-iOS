//
//  Modules.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/18/24.
//

import ProjectDescription

public enum Modules {
  case data
  case domain
  case presentation
}

// MARK: - Data

public extension Modules {
  enum Data: String {
    case LocalStorage // 임시
    
    var path: String {
      "Data/\(self.rawValue)"
    }
    
    var targetName: String {
      "\(self.rawValue)"
    }
  }
}

// MARK: - Domain

public extension Modules {
  enum Domain: String {
    case Entities
    
    var path: String {
      switch self {
      case .Entities: "Domain/\(self.rawValue)"
      default: "Domain/UseCase/\(self.rawValue)"
      }
    }
    
    var targetName: String {
      switch self {
      case .Entities:  "\(self.rawValue)"
      default: "\(self.rawValue)UseCase"
      }
    }
  }
}

// MARK: - Presentation

public extension Modules {
  enum Presentation: String {
    case DesignSystem
    case MatchingMain
    
    var path: String {
      switch self {
      case .DesignSystem: "Presentation/\(self.rawValue)"
      default: "Presentation/Feature/\(self.rawValue)"
      }
    }
    
    var targetName: String {
      switch self {
      case .DesignSystem: "\(self.rawValue)"
      default: "\(self.rawValue)Feature"
      }
    }
  }
}
