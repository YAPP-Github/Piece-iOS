//
//  MatchingMainViewModel.swift
//  MatchingMain
//
//  Created by eunseou on 1/4/25.
//


import DesignSystem
import Router
import SwiftUI
import Observation
import UseCases

@Observable
final class MatchingMainViewModel {
  enum MatchingButtonState {
    case checkMatchingPiece // 매칭 조각 확인하기
    case acceptMatching // 매칭 수락하기
    case responseComplete // 응답 완료
    case checkContact // 연락처 확인하기
    
    var title: String {
      switch self {
      case .checkMatchingPiece:
        "매칭 조각 확인하기"
      case .acceptMatching:
        "매칭 수락하기"
      case .responseComplete:
        "응답 완료"
      case .checkContact:
        "연락처 확인하기"
      }
    }
    
    var buttonType: RoundedButton.ButtonType {
      switch self {
      case .checkMatchingPiece, .acceptMatching, .checkContact:
          .solid
      case .responseComplete:
          .disabled
      }
    }
    
    var destination: Route? {
      switch self { // TODO: - 매칭 심사중일 때 내 프로필 확인하기 화면
      case .checkMatchingPiece: .matchProfileBasic
      case .acceptMatching: nil
      case .responseComplete: nil
      case .checkContact: nil // TODO: - 연락처 확인 화면으로 변경
      }
    }
  }
  
  enum Action {
    case tapProfileInfo
    case tapMatchingButton
    case didAcceptMatch
  }
  
  var isMatchAcceptAlertPresented: Bool = false
  
  private(set) var name: String = ""
  private(set) var description: String = ""
  private(set) var age: String = ""
  private(set) var location: String = ""
  private(set) var job: String = ""
  private(set) var tags: [String] = []
  private(set) var error: Error?
  private let acceptMatchUseCase: AcceptMatchUseCase
  private let getMatchesProfileBasicUseCase: GetMatchProfileBasicUseCase
  
  var buttonTitle: String {
    matchingButtonState.title
  }
  var buttonStatus: RoundedButton.ButtonType {
    matchingButtonState.buttonType
  }
  var matchingButtonDestination: Route? {
    matchingButtonState.destination
  }
  var matchingButtonState: MatchingButtonState = .acceptMatching
  var matchingStatus: MatchingAnswer.MatchingStatus = .before
  
  init(
    acceptMatchUseCase: AcceptMatchUseCase,
    getMatchesProfileBasicUseCase: GetMatchProfileBasicUseCase
  ) {
    self.acceptMatchUseCase = acceptMatchUseCase
    self.getMatchesProfileBasicUseCase = getMatchesProfileBasicUseCase
    
    fetchInfo()
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapMatchingButton:
      handleMatchingButtonTap()
      
    case .didAcceptMatch:
      Task { await acceptMatch() }
    default: return
    }
  }
  
  private func handleMatchingButtonTap() {
    if matchingButtonDestination == nil {
      switch matchingButtonState {
      case .acceptMatching:
        isMatchAcceptAlertPresented = true
      default: return
      }
    }
  }
  
  private func fetchInfo() {
    Task {
      do {
        let basicInfo = try await getMatchesProfileBasicUseCase.execute()
        name = basicInfo.nickname
        description = basicInfo.description
        age = String(basicInfo.age)
        location = basicInfo.location
        job = basicInfo.job
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  private func acceptMatch() async {
    do {
      _ = try await acceptMatchUseCase.execute()
    } catch {
      self.error = error
    }
  }
}
