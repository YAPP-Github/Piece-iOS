//
// BasicInfoViewModel.swift
// MatchingDetail
//
// Created by summercat on 2025/01/02.
//

import Observation
import UseCases

@Observable
final class BasicInfoViewModel {
  struct Dependencies {
    let getMatchProfileBasicUseCase: GetMatchProfileBasicUseCase
    
    public init(getMatchProfileBasicUseCase: GetMatchProfileBasicUseCase) {
      self.getMatchProfileBasicUseCase = getMatchProfileBasicUseCase
    }
  }
  
  enum Action {
    case didTapCloseButton
    case didTapMoreButton
    case didTapNextButton
  }
  
  private enum Constant {
    static let navigationTitle = ""
    static let title = "오늘의 매칭 조각"
  }

  
  let navigationTitle = Constant.navigationTitle
  let title = Constant.title
  private(set) var isLoading = true
  private(set) var error: Error?
  private(set) var matchingBasicInfoModel: BasicInfoModel
  private let getMatchProfileBasicUseCase: GetMatchProfileBasicUseCase
  
  init(dependencies: Dependencies) {
    self.getMatchProfileBasicUseCase = dependencies.getMatchProfileBasicUseCase
    self.matchingBasicInfoModel = BasicInfoModel(
      shortIntroduce: "",
      nickname: "",
      age: -1,
      birthYear: "",
      height: -1,
      weight: -1,
      region: "",
      job: "",
      isSmoker: false
    )
    
    Task {
      await fetchMatchingBasicInfo()
    }
  }
  
  func handleAction(_ action: Action) {
    
  }
  
  private func fetchMatchingBasicInfo() async {
    do {
      let entity = try await getMatchProfileBasicUseCase.execute()
      matchingBasicInfoModel = BasicInfoModel(
        shortIntroduce: entity.shortIntroduce,
        nickname: entity.nickname,
        age: entity.age,
        birthYear: entity.birthYear,
        height: entity.height,
        weight: entity.weight,
        region: entity.region,
        job: entity.job,
        isSmoker: entity.isSmoker
      )
      error = nil
    } catch {
      self.error = error
    }
    isLoading = false
  }
}
