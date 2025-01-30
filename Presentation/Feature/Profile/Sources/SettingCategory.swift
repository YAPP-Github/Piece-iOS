//
//  SettingCategory.swift
//  Profile
//
//  Created by summercat on 1/30/25.
//

import DesignSystem
import SwiftUI

struct SettingCategory: View {
  private let icon: Image
  private let categoryText: String
  private let descriptionText: String
  
  init(
    icon: Image,
    categoryText: String,
    descriptionText: String
  ) {
    self.icon = icon
    self.categoryText = categoryText
    self.descriptionText = descriptionText
  }
  
  var body: some View {
    HStack(alignment: .top, spacing: 4) {
      VStack(alignment: .leading, spacing: 8) {
        categoryRow
        description
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      DesignSystemAsset.Icons.chevronRight24.swiftUIImage
        .renderingMode(.template)
        .foregroundStyle(Color.grayscaleDark1)
    }
    .padding(.vertical, 16)
  }
  
  private var categoryRow: some View {
    HStack(alignment: .center, spacing: 8) {
      icon
        .renderingMode(.template)
        .resizable()
        .frame(width: 20, height: 20)
        .foregroundStyle(Color.grayscaleDark1)
      
      Text(categoryText)
        .pretendard(.heading_S_SB)
        .foregroundStyle(Color.grayscaleDark1)
    }
  }
  
  private var description: some View {
    Text(descriptionText)
      .pretendard(.caption_M_M)
      .foregroundStyle(Color.grayscaleDark3)
      .padding(.leading, 28)
  }
}
