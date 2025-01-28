//
//  ObservableScrollView.swift
//  DesignSystem
//
//  Created by summercat on 1/5/25.
//

import SwiftUI

public struct ObservableScrollView<Content: View>: View {
  @Binding var contentOffset: CGFloat
  private let content: Content
  
  public init(contentOffset: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
    self._contentOffset = contentOffset
    self.content = content()
  }
  
  public var body: some View {
    ScrollView {
      content
        .background {
          GeometryReader { geometry in
            Color.clear
              .preference(
                key: ContentOffsetKey.self,
                value: geometry.frame(in: .named("scrollView")).minY
              )
          }
        }
    }
    .coordinateSpace(name: "scrollView")
    .onPreferenceChange(ContentOffsetKey.self) { value in
      self.contentOffset = value
    }
  }
}
