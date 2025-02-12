//
//  SettingsToggleView.swift
//  Settings
//
//  Created by summercat on 2/12/25.
//

import DesignSystem
import SwiftUI

struct SettingsToggleView: View {
  let title: String
  @Binding var isOn: Bool
  let onToggle: ((Bool) -> Void)?
  
  var body: some View {
    HStack(alignment: .center, spacing: 0) {
      Text(title)
        .pretendard(.heading_S_SB)
        .padding(.vertical, 16)
      Spacer()
      PCToggle(isOn: $isOn)
        .onChange(of: isOn) { _, newValue in
          onToggle?(newValue)
        }
    }
  }
}
