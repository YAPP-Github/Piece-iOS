//
//  NavigationBar.swift
//  DesignSystem
//
//  Created by eunseou on 12/30/24.
//

import SwiftUI

// NavigationBar 뷰 정의
public struct NavigationBar<RightButton: View>: View {

  public init(
    title: String,
    titleColor: Color = .grayscaleBlack,
    leftButtonTap: (() -> Void)? = nil,
    rightButton: RightButton,
    backgroundColor: Color = .clear
  ) {
    self.title = title
    self.titleColor = titleColor
    self.leftButtonTap = leftButtonTap
    self.rightButton = rightButton
    self.backgroundColor = backgroundColor
  }
  
  // MARK: - Body
  public var body: some View {
    ZStack {
      backgroundColor.edgesIgnoringSafeArea(.top)
      HStack {
        if let leftButtonTap {
          Button(action: leftButtonTap) {
            Image(.chevronLeft32)
              .renderingMode(.template)
              .foregroundColor(titleColor)
          }
        }
        
        Spacer()
        
        rightButton
      }
      .padding(.horizontal, 20)
      
      Text(title)
        .foregroundColor(titleColor)
        .pretendard(.heading_S_SB)
    }
    .frame(maxWidth: .infinity)
    .frame(height: 60)
  }
  
  private let title: String
  private let titleColor: Color
  private let leftButtonTap: (() -> Void)?
  private let rightButton: RightButton
  private let backgroundColor: Color
}

#Preview {
  VStack {
    NavigationBar(
      title: "title",
      leftButtonTap: {
      },
      rightButton:
        Button { } label: { DesignSystemAsset.Icons.close32.swiftUIImage }
    )
    NavigationBar(
      title: "title",
      rightButton:
        Button { } label: { DesignSystemAsset.Icons.close32.swiftUIImage }
    )
    NavigationBar(
      title: "title",
      rightButton:
        Button { } label: { Text("label") }
    )
    NavigationBar(
      title: "프로필 생성하기",
      rightButton: EmptyView(),
      backgroundColor: .grayscaleWhite
    )
  }}
