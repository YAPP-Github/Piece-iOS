//
//  AppEnvironment.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/19/24.
//

import ProjectDescription

public enum AppEnvironment: String {
  case dev
  case prod
  
  public var configurationName: ConfigurationName {
    return ConfigurationName.configuration(self.rawValue)
  }
}
