//
//  SettingsEtcSectionview.swift
//  Settings
//
//  Created by summercat on 2/12/25.
//

import DesignSystem
import SwiftUI

struct SettingsEtcSectionview: View {
  let title: String
  let logoutTitle: String
  let didTapLogoutItem: () -> Void
  
  var body: some View {
    VStack(spacing: 8) {
      SettingsSectionHeaderTitleView(title: title)
      VStack(spacing: 0) {
        SettingsTextItemView(
          title: logoutTitle,
          textColor: .grayscaleDark1
        )
        .onTapGesture {
          didTapLogoutItem()
        }
      }
    }
  }
}
