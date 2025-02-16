//
//  WaitingAISummaryViewModel.swift
//  SignUp
//
//  Created by summercat on 2/16/25.
//

import Observation
import UseCases

@Observable
final class WaitingAISummaryViewModel {
  enum Action {
    case onAppear
    case onDisappear
  }
  
  init(
    getAISummaryUseCase: GetAISummaryUseCase,
    finishAISummaryUseCase: FinishAISummaryUseCase
  ) {
    self.getAISummaryUseCase = getAISummaryUseCase
    self.finishAISummaryUseCase = finishAISummaryUseCase
  }
  
  private(set) var isCreatingSummary: Bool = true
  private var sseTask: Task<Void, Never>?
  
  private let getAISummaryUseCase: GetAISummaryUseCase
  private let finishAISummaryUseCase: FinishAISummaryUseCase
  
  func handleAction(_ action: Action) {
    switch action {
    case .onAppear:
      createAISummary()
    case .onDisappear:
      finishSSEConnection()
    }
  }
  
  private func createAISummary() {
    sseTask = Task {
      do {
        for try await _ in getAISummaryUseCase.execute() { }
        
        _ = try await finishAISummaryUseCase.execute()
        isCreatingSummary = false

      } catch {
        print(error)
      }
    }
  }
  
  private func finishSSEConnection() {
    sseTask?.cancel()
  }
}
