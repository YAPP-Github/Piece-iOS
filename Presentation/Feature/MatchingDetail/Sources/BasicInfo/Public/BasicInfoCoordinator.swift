//
//  BasicInfoCoordinator.swift
//  MatchingDetail
//
//  Created by summercat on 1/28/25.
//

import Router
import SwiftUI
import UseCases

public struct BasicInfoCoordinator: View {
  private let dependencies: Dependencies
  
  public init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
  
  public var body: some View {
    BasicInfoView(
      dependencies: .init(
        getMatchProfileBasicUseCase: dependencies.getMatchProfileBasicUseCase
      )
    )
//    .navigationDestination(for: Destination.self) { destination in
//      switch destination {
//      case .valueTalk:
//        ValueTalkView(viewModel: <#T##ValueTalkViewModel#>)
//        
//      case .valuePick:
//        ValuePickView(viewModel: <#T##ValuePickViewModel#>)
//      }
//    }
  }
}

public extension BasicInfoCoordinator {
  struct Dependencies {
    let getMatchProfileBasicUseCase: GetMatchProfileBasicUseCase
    
    public init(getMatchProfileBasicUseCase: GetMatchProfileBasicUseCase) {
      self.getMatchProfileBasicUseCase = getMatchProfileBasicUseCase
    }
  }
  
  enum Destination {
    case valueTalk
    case valuePick
  }
}
