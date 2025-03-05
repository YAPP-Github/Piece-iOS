//
//  TabBarButton.swift
//  Home
//
//  Created by summercat on 3/6/25.
//

import SwiftUI

// MARK: - 탭바 버튼
struct TabBarButton: View {
  init(
    tabBarImage: Image,
    tabBarTitle: String,
    isSelected: Bool
  ) {
    self.tabBarImage = tabBarImage
    self.tabBarTitle = tabBarTitle
    self.isSelected = isSelected
  }
  
  var body: some View {
    VStack(spacing: 0) {
      tabBarImage
        .renderingMode(.template)
      Text(tabBarTitle)
        .pretendard(.caption_M_M)
    }
    .foregroundColor(isSelected ? .primaryDefault : .grayscaleDark3)
  }
  
  private let tabBarImage: Image
  private let tabBarTitle: String
  private let isSelected: Bool
}

