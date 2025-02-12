//
//  SettingsSectionHeaderTitleView.swift
//  Settings
//
//  Created by summercat on 2/12/25.
//

import SwiftUI
import DesignSystem

struct SettingsSectionHeaderTitleView: View {
  let title: String
  
  var body: some View {
    HStack {
      Text(title)
        .pretendard(.body_S_M)
        .foregroundStyle(Color.grayscaleDark2)
      Spacer()
    }
  }
}
