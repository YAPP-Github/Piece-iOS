//
//  Router.swift
//  Router
//
//  Created by summercat on 1/19/25.
//

import Observation
import SwiftUI

@Observable
public final class Router {
  public init() { }
  
  public var navigationPath = NavigationPath()
  
  public func push(to destination: any Hashable) {
    navigationPath.append(destination)
  }
  
  public func pop() {
    navigationPath.removeLast()
  }
  
  public func popToRoot() {
    navigationPath.removeLast(navigationPath.count)
  }
}
