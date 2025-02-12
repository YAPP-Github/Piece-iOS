//
//  SettingsViewFactory.swift
//  Settings
//
//  Created by summercat on 2/12/25.
//

import SwiftUI
import UseCases

public struct SettingsViewFactory {
  public static func createSettingsView(fetchTermsUseCase: FetchTermsUseCase) -> some View {
    SettingsView(fetchTermsUseCase: fetchTermsUseCase)
  }
  
  public static func createSettingsWebView(title: String, uri: String) -> some View {
    SettingsWebView(title: title, uri: uri)
  }
}
