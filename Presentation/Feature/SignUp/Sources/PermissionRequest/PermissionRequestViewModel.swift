//
//  PermissionRequestViewModel.swift
//  SignUp
//
//  Created by eunseou on 1/15/25.
//

import SwiftUI
import DesignSystem
import Observation

@Observable
final class PermissionRequestViewModel {
  var isCameraPermissionGranted: Bool = false // 카메라 권한
  var isNotificationPermissionGranted: Bool = false // 알림 권한
  var isContactsPermissionGranted: Bool = false // 연락처 권한
  var shouldShowSettingsAlert: Bool = false // 권한 요청 1회 거절 시 -> 설정창으로 보내기 위한 flag
  var nextButtonType: RoundedButton.ButtonType {
    isCameraPermissionGranted ? .solid : .disabled
  }
  private var dismissAction: (() -> Void)?
  
  enum Action {
    case showShettingAlert
    case tapNextButton
    case tapBackButton
  }
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapBackButton:
      dismissAction?()
    default: return
    }
  }
  
  func setDismissAction(_ dismiss: @escaping () -> Void) {
    self.dismissAction = dismiss
  }
}
