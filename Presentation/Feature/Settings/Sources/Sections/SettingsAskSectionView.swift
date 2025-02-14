//
//  SettingsAskSectionView.swift
//  Settings
//
//  Created by summercat on 2/12/25.
//

import SwiftUI
import DesignSystem

struct SettingsAskSectionView: View {
  let title: String
  let askTitle: String
  let didTapAskView: () -> Void
  
  var body: some View {
    VStack(spacing: 8) {
      SettingsSectionHeaderTitleView(title: title)
      VStack(spacing: 0) {
        SettingChevronView(title: askTitle)
          .onTapGesture {
            didTapAskView()
          }
      }
    }
  }
}
