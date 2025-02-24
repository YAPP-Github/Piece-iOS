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
    case pending
    case checkMatchingPiece // 매칭 조각 확인하기
    case acceptMatching // 매칭 수락하기
    case responseComplete // 응답 완료
    case checkContact(nickname: String) // 연락처 확인하기
    
    var title: String {
      switch self {
      case .pending:
        "내 프로필 확인하기"
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
      case .pending, .checkMatchingPiece, .acceptMatching, .checkContact:
          .solid
      case .responseComplete:
          .disabled
      }
    }
    
    var destination: Route? {
      switch self {
      case .pending: .previewProfileBasic
      case .checkMatchingPiece: .matchProfileBasic
      case .acceptMatching: nil
      case .responseComplete: nil
      case let .checkContact(nickname): .matchResult(nickname: nickname)
      }
    }
  }
  
  enum Action {
    case tapProfileInfo // 매칭 조각 확인하고 상대 프로필 눌렀을때
    case tapMatchingButton // 하단 CTA 매칭 버튼 누를시
    case didAcceptMatch // 매칭 수락하기
    case checkContacts // 연락처 확인하기
  }
  
  var isMatchAcceptAlertPresented: Bool = false
  var isProfileRejectAlertPresented: Bool {
    rejectReasonImage || rejectReasonValues
  }
  var profileRejectAlertMessage: String {
    var messages: [String] = []
    if rejectReasonImage { messages.append("얼굴이 잘 나온 사진으로 변경해주세요") }
    if rejectReasonValues { messages.append("가치관 talk을 좀 더 정성스럽게 써주세요")}
    return messages.joined(separator: "\n")
  }
  
  private(set) var name: String = ""
  private(set) var description: String = ""
  private(set) var age: String = ""
  private(set) var location: String = ""
  private(set) var job: String = ""
  private(set) var tags: [String] = []
  private(set) var error: Error?
  private(set) var profileStatus: String = ""
  private(set) var rejectReasonImage: Bool = false
  private(set) var rejectReasonValues: Bool = false
  private let acceptMatchUseCase: AcceptMatchUseCase
  private let getMatchesInfoUseCase: GetMatchesInfoUseCase
  private let getMatchContactsUseCase: GetMatchContactsUseCase
  private let getUserRejectUseCase: GetUserRejectUseCase
  private let patchMatchesCheckPieceUseCase: PatchMatchesCheckPieceUseCase
  
  var buttonTitle: String {
    matchingButtonState.title
  }
  var buttonStatus: RoundedButton.ButtonType {
    matchingButtonState.buttonType
  }
  var matchingButtonDestination: Route? {
    matchingButtonState.destination
  }
  var destination: Route?
  var matchingButtonState: MatchingButtonState = .acceptMatching
  var matchingStatus: MatchingAnswer.MatchingStatus = .before
  
  init(
    acceptMatchUseCase: AcceptMatchUseCase,
    getMatchesInfoUseCase: GetMatchesInfoUseCase,
    getMatchContactsUseCase: GetMatchContactsUseCase,
    getUserRejectUseCase: GetUserRejectUseCase,
    patchMatchesCheckPieceUseCase: PatchMatchesCheckPieceUseCase
  ) {
    self.acceptMatchUseCase = acceptMatchUseCase
    self.getMatchesInfoUseCase = getMatchesInfoUseCase
    self.getMatchContactsUseCase = getMatchContactsUseCase
    self.getUserRejectUseCase = getUserRejectUseCase
    self.patchMatchesCheckPieceUseCase = patchMatchesCheckPieceUseCase
    
    Task {
      await fetchInfo()
      await fetchUserJectState()
    }
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapProfileInfo:
      destination = .matchProfileBasic
    case .tapMatchingButton:
      handleMatchingButtonTap()
      
    case .didAcceptMatch:
      Task { await acceptMatch() }
      
    case .checkContacts:
      Task { await checkContacts() }
    }
  }
  
  private func handleMatchingButtonTap() {
    if matchingButtonDestination == nil {
      switch matchingButtonState {
      case .acceptMatching:
        isMatchAcceptAlertPresented = true
      case .checkContact:
        Task { await checkContacts() }
      case .checkMatchingPiece:
        Task { await patchCheckMatchingPiece() }
      case .pending:
        return
      case .responseComplete:
        return
      }
    }
  }
  
  private func fetchInfo() async {
      do {
        let info = try await getMatchesInfoUseCase.execute()
        
        name = info.nickname
        description = info.description
        age = info.birthYear
        location = info.location
        job = info.job
        tags = info.matchedValueList
      } catch {
        print(error.localizedDescription)
      }
  }
  
  private func fetchUserJectState() async {
    do {
      let userRejectState = try await getUserRejectUseCase.execute()
      
      profileStatus = userRejectState.profileStatus
      rejectReasonImage = userRejectState.reasonImage
      rejectReasonValues = userRejectState.reasonValues
    } catch {
      print(error.localizedDescription)
    }
  }
  
  private func acceptMatch() async {
    do {
      _ = try await acceptMatchUseCase.execute()
    } catch {
      self.error = error
    }
  }
  
  private func checkContacts() async {
    do {
      _ = try await getMatchContactsUseCase.execute()
    } catch {
      self.error = error
    }
  }
  
  private func patchCheckMatchingPiece() async {
    do {
      _ = try await patchMatchesCheckPieceUseCase.execute()
    } catch {
      self.error = error
    }
  }
}
