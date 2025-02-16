//
//  Router.swift
//  Router
//
//  Created by summercat on 1/29/25.
//

import Observation
import SwiftUI

@Observable
public final class Router {
  public var path = NavigationPath()
  public var initialRoute: Route
  
  public init(initialRoute: Route = .splash) {
    self.initialRoute = initialRoute
  }
  
  public func push(to route: Route) {
    path.append(route)
  }
  
  public func pop() {
    path.removeLast()
  }
  
  public func popToRoot() {
    path.removeLast(path.count)
  }
  public func setRoute(_ route: Route) {
    initialRoute = route
    path.removeLast(path.count)
  }
}
