//
//  SettingsTextItemView.swift
//  Settings
//
//  Created by summercat on 2/12/25.
//

import DesignSystem
import SwiftUI

struct SettingsTextItemView: View {
  let image: Image?
  let title: String
  let textColor: Color
  
  init(image: Image? = nil, title: String, textColor: Color) {
    self.image = image
    self.title = title
    self.textColor = textColor
  }
  
  var body: some View {
    HStack(alignment: .center, spacing: 8) {
      if let image {
        image
          .resizable()
          .frame(width: 20, height: 20)
      }
      Text(title)
        .pretendard(.heading_S_SB)
        .padding(.vertical, 16)
        .foregroundStyle(textColor)
      Spacer()
    }
  }
}
