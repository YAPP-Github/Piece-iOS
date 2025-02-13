//
//  SettingsChevronView.swift
//  Settings
//
//  Created by summercat on 2/12/25.
//

import DesignSystem
import SwiftUI

struct SettingChevronView: View {
  let title: String
  
  var body: some View {
    HStack(alignment: .center, spacing: 0) {
      Text(title)
        .pretendard(.heading_S_SB)
        .padding(.vertical, 16)
      Spacer()
      DesignSystemAsset.Icons.chevronRight24.swiftUIImage
        .renderingMode(.template)
        .foregroundColor(Color.grayscaleBlack)
    }
  }
}

#Preview {
  SettingChevronView(title: "메뉴이름")
}
