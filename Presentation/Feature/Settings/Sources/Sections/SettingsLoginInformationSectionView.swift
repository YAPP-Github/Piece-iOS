//
//  SettingsLoginInformationSectionView.swift
//  Settings
//
//  Created by summercat on 2/12/25.
//

import DesignSystem
import SwiftUI

struct SettingsLoginInformationSectionView: View {
  let title: String
  @Binding var loginInformationImage: Image?
  @Binding var loginEmail: String

  var body: some View {
    VStack(spacing: 8) {
      SettingsSectionHeaderTitleView(title: title)
      VStack(spacing: 0) {
        SettingsTextItemView(
          image: loginInformationImage,
          title: loginEmail,
          textColor: .grayscaleDark1
        )
      }
    }
  }
}
