//
//  PermissionRequestViewModel.swift
//  SignUp
//
//  Created by eunseou on 1/15/25.
//

import SwiftUI
import DesignSystem
import Observation
import UseCases

@Observable
final class PermissionRequestViewModel {
  private(set) var isCameraPermissionGranted: Bool = false // 카메라 권한 여부
  private(set) var isNotificationPermissionGranted: Bool = false // 알림 권한 여부
  private(set) var isContactsPermissionGranted: Bool = false // 연락처 권한 여부
  var shouldShowSettingsAlert: Bool = false // 카메라 권한 거절 상태에 설정창으로 보내기 위한 flag
  var nextButtonType: RoundedButton.ButtonType {
    isCameraPermissionGranted ? .solid : .disabled
  }
  private var dismissAction: (() -> Void)?
  private let requestCameraUseCase: RequestCameraUseCase
  private let requestContactsUseCase: RequestContactsUseCase
  private let requestNotificationUseCase: RequestNotificationUseCase
  
  enum Action {
    case showShettingAlert
    case tapNextButton
    case tapBackButton
    case cancelAlert
  }
  
  init(
    requestCameraUseCase: RequestCameraUseCase,
    requestContactsUseCase: RequestContactsUseCase,
    requestNotificationUseCase: RequestNotificationUseCase
  ) {
    self.requestCameraUseCase = requestCameraUseCase
    self.requestContactsUseCase = requestContactsUseCase
    self.requestNotificationUseCase = requestNotificationUseCase
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .showShettingAlert:
      openSettings()
    case .tapBackButton:
      dismissAction?()
    case .cancelAlert:
      Task { await resetAlertState() }
    default: return
    }
  }
  
  func setDismissAction(_ dismiss: @escaping () -> Void) {
    self.dismissAction = dismiss
  }
  
  func checkPermissions() async {
    await fetchPermissions()
    await updateSettingsAlertState()
  }
  
  private func fetchPermissions() async {
    do {
      isCameraPermissionGranted = await requestCameraUseCase.execute()
      isNotificationPermissionGranted = try await requestNotificationUseCase.execute()
      isContactsPermissionGranted = try await requestContactsUseCase.execute()
    } catch {
      print("Permission request error: \(error)")
    }
  }
  
  @MainActor
  private func updateSettingsAlertState() async {
    shouldShowSettingsAlert = !isCameraPermissionGranted
  }
  
  @MainActor
  private func resetAlertState() async {
    shouldShowSettingsAlert = false
    try? await Task.sleep(nanoseconds: 100_000_000)  // 0.1초 뒤에 설정 창이 뜨도록
    shouldShowSettingsAlert = true
  }
  
  private func openSettings() {
    guard let settingUrl = URL(string: UIApplication.openSettingsURLString),
          UIApplication.shared.canOpenURL(settingUrl) else {
      return
    }
    UIApplication.shared.open(settingUrl)
  }
}
