//
// MatchProfileBasicViewModel.swift
// MatchingDetail
//
// Created by summercat on 2025/01/02.
//

import Observation
import UseCases

@Observable
final class MatchProfileBasicViewModel {
  enum Action {
    case didTapMoreButton
  }
  
  private enum Constant {
    static let navigationTitle = ""
    static let title = "오늘의 매칭 조각"
  }

  @ObservationIgnored let navigationTitle = Constant.navigationTitle
  @ObservationIgnored let title = Constant.title
  
  private(set) var isLoading = true
  private(set) var error: Error?
  private(set) var matchingBasicInfoModel: BasicInfoModel?
  private let getMatchProfileBasicUseCase: GetMatchProfileBasicUseCase
  
    self.getMatchProfileBasicUseCase = getMatchProfileBasicUseCase
    Task {
      await fetchMatchingBasicInfo()
    }
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .didTapMoreButton:
      return
    }
  }
  
  private func fetchMatchingBasicInfo() async {
    do {
      let entity = try await getMatchProfileBasicUseCase.execute()
      matchingBasicInfoModel = BasicInfoModel(
        id: entity.id,
        nickname: entity.nickname,
        shortIntroduction: entity.shortIntroduction,
        age: entity.age,
        birthYear: entity.birthYear,
        height: entity.height,
        weight: entity.weight,
        region: entity.location,
        job: entity.job,
        smokingStatus: entity.smokingStatus
      )
      error = nil
    } catch {
      self.error = error
    }
    isLoading = false
  }
}
