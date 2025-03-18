//
//  PCTextEditor.swift
//  DesignSystem
//
//  Created by eunseou on 1/30/25.
//

import SwiftUI

private enum PCTextEditorConstant {
  static let horizontalPadding: CGFloat = 16
  static let verticalPadding: CGFloat = 14
  static let maxTextWidth: CGFloat = 243
}

public struct PCTextEditor<FocusField: Hashable>: View {
  @Binding private var text: String
  private var focusState: FocusState<FocusField>.Binding
  private let focusField: FocusField
  private let action: () -> Void
  private let showDeleteButton: Bool
  private let tapDeleteButton: (() -> Void)?
  private let image: Image
  
  public init(
    text: Binding<String>,
    focusState: FocusState<FocusField>.Binding,
    focusField: FocusField,
    image: Image,
    showDeleteButton: Bool,
    tapDeleteButton: (() -> Void)? = nil,
    action: @escaping () -> Void
  ) {
    self._text = text
    self.focusState = focusState
    self.focusField = focusField
    self.image = image
    self.showDeleteButton = showDeleteButton
    self.tapDeleteButton = tapDeleteButton
    self.action = action
  }
  
  public var body: some View {
    HStack(spacing: 16) {
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
        
        TextEditor(text: $text)
          .pretendard(.body_M_M)
          .foregroundStyle(Color.grayscaleBlack)
          .frame(width: PCTextEditorConstant.maxTextWidth)
          .scrollContentBackground(.hidden)
          .background(Color.grayscaleLight3)
          .focused(focusState, equals: focusField)
          .onChange(of: text) { _, newValue in
            text = newValue
          }
      }
      .padding(.horizontal, PCTextEditorConstant.horizontalPadding)
      .padding(.vertical, PCTextEditorConstant.verticalPadding)
      .background(Color.grayscaleLight3)
      .cornerRadius(8)
      
      if showDeleteButton {
        Button{
          tapDeleteButton?()
        } label: {
          DesignSystemAsset.Icons.deletCircle20.swiftUIImage
            .renderingMode(.template)
            .foregroundStyle(Color.grayscaleLight1)
        }
      }
    }
  }
}


// MARK: - Preview
#Preview {
  struct PCTextEditorPreview: View {
    @State private var text: String = ""
    @FocusState private var focusField: String?
    
    var body: some View {
      PCTextEditor(
        text: $text,
        focusState: $focusField,
        focusField: "test",
        image: DesignSystemAsset.Icons.kakao20.swiftUIImage,
        showDeleteButton: true,
        action: { print("Button tapped") }
      )
      .padding()
    }
  }
  return PCTextEditorPreview()
}
