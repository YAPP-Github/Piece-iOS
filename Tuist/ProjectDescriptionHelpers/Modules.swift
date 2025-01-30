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
  case utility
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
    case UseCases
    
    var path: String {
      switch self {
      default: "Domain/\(self.rawValue)"
      }
    }
    
    var targetName: String {
      "\(self.rawValue)"
    }
  }
}

// MARK: - Utility

public extension Modules {
  enum Utility: String {
    case PCFoundationExtension
    
    var path: String {
      "Utility/\(self.rawValue)"
    }
    
    var targetName: String {
      "\(self.rawValue)"
    }
  }
}

// MARK: - Presentation

public extension Modules {
  enum Presentation: String {
    case DesignSystem
    case Router
    case Coordinator
    case Login
    case SignUp
    case Home
    case Profile
    case MatchingMain
    case MatchingDetail
    
    var path: String {
      switch self {
      case .DesignSystem, .Router, .Coordinator: "Presentation/\(self.rawValue)"
      default: "Presentation/Feature/\(self.rawValue)"
      }
    }
    
    var targetName: String {
      "\(self.rawValue)"
    }
  }
}
