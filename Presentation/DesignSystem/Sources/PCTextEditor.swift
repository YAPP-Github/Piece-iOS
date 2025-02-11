//
//  PCTextEditor.swift
//  DesignSystem
//
//  Created by eunseou on 1/30/25.
//

import SwiftUI

public struct PCTextEditor: View {
  private enum Constant {
    static let horizontalPadding: CGFloat = 16
    static let verticalPadding: CGFloat = 14
    static let maxTextWidth: CGFloat = 243
  }
  
  @Binding private var text: String
  private let action: () -> Void
  private let image: Image
  
  public init(
    text: Binding<String>,
    image: Image,
    action: @escaping () -> Void
  ) {
    self._text = text
    self.image = image
    self.action = action
  }
  
  public var body: some View {
    HStack(spacing: 14) {
      VStack {
        Button {
          action()
        } label:{
          HStack {
            image
            DesignSystemAsset.Icons.chevronDown24.swiftUIImage
          }
        }
        Spacer()
      }
      
      DynamicTextView(text: $text)
      .pretendard(.body_M_M)
      .foregroundStyle(Color.grayscaleBlack)
      .frame(width: Constant.maxTextWidth)
      .background(Color.grayscaleLight3)
    }
    .padding(.horizontal, Constant.horizontalPadding)
    .padding(.vertical, Constant.verticalPadding)
    .background(Color.grayscaleLight3)
    .cornerRadius(8)
  }
}


// MARK: - Preview
#Preview {
  struct PCTextEditorPreview: View {
    @State private var text: String = ""
    var body: some View {
      PCTextEditor(
        text: $text,
        image: DesignSystemAsset.Icons.kakao20.swiftUIImage,
        action: { print("Button tapped") } 
      )
      .padding()
    }
  }
  return PCTextEditorPreview()
}
