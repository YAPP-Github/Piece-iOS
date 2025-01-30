//
//  HomeNavigationBar.swift
//  DesignSystem
//
//  Created by summercat on 1/30/25.
//

import SwiftUI

public struct HomeNavigationBar: View {
  public init(
    title: String,
    foregroundColor: Color,
    rightIcon: Image? = nil,
    rightIconTap: (() -> Void)? = nil
  ) {
    self.title = title
    self.foregroundColor = foregroundColor
    self.rightIcon = rightIcon
    self.rightIconTap = rightIconTap
  }
  
  public var body: some View {
    HStack(alignment: .center, spacing: 20) {
      Text(title)
        .foregroundStyle(foregroundColor)
        .wixMadeforDisplay(.branding)
        .frame(maxWidth: .infinity, alignment: .leading)
      if let rightIcon {
        rightIcon
          .renderingMode(.template)
          .foregroundStyle(foregroundColor)
          .onTapGesture {
            rightIconTap?()
        }
      }
    }
    .frame(maxWidth: .infinity)
    .frame(height: 60)
    .padding(.horizontal, 20)
    .padding(.vertical, 14)
    .background(Color.clear)
  }
  
  public let title: String
  public let foregroundColor: Color
  public let rightIcon: Image?
  public let rightIconTap: (() -> Void)?
}
