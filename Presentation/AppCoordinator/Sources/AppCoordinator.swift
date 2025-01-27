//
//  AppCoordinator.swift
//  Router
//
//  Created by summercat on 1/25/25.
//

import Router
import SwiftUI

public struct AppCoordinator: View {
  @State var router = Router()
  
  public init() { }
  
  public var body: some View {
    NavigationStack(path: $router.navigationPath) {
      // TODO: - Splash 화면으로 변경
      Rectangle()
    }
    .environment(router)
  }
}
