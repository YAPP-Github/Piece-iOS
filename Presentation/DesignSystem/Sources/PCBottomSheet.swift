//
//  PCButtonSheet.swift
//  DesignSystem
//
//  Created by eunseou on 2/1/25.
//

import SwiftUI

public struct PCBottomSheet<Content: View>: View {
  @Binding var isPresented: Bool
  private var height: CGFloat = 300
  private let titleText: String
  private let subtitleText: String?
  private let buttonText: String
  private let buttonAction: (() -> Void)?
  private let content: Content
  
  public init(
    isPresented: Binding<Bool>,
    height: CGFloat,
    titleText: String,
    subtitleText: String? = nil,
    buttonText: String,
    buttonAction: (() -> Void)? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self._isPresented = isPresented
    self.height = height
    self.titleText = titleText
    self.subtitleText = subtitleText
    self.buttonText = buttonText
    self.buttonAction = buttonAction
    self.content = content()
  }
  
  public var body: some View {
    if isPresented {
      ZStack {
        Color.black.opacity(0.4)
          .ignoresSafeArea()
          .onTapGesture {
            isPresented = false
          }
        VStack {
          Spacer()
          
          VStack(spacing: 0) {
            Spacer()
              .frame(height: 36)
            
            VStack(alignment: .leading, spacing: 8){
              title
              if subtitleText != nil {
                subtitle
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            content
              .frame(maxWidth: .infinity)
            
            Spacer()
            
            button
          }
          .frame(height: height)
          .padding(.horizontal, 20)
          .background(
            RoundedRectangle(cornerRadius: 20)
              .fill(Color.grayscaleWhite)
              .ignoresSafeArea(edges: .bottom)
          )
        }
        .transition(.move(edge: .bottom))
        .animation(.spring(.smooth), value: isPresented)
      }
    }
  }
  
  private var title: some View {
    Text(titleText)
      .foregroundStyle(Color.grayscaleBlack)
      .pretendard(.heading_L_SB)
  }
  
  @ViewBuilder
  private var subtitle: some View {
    Text("Subtitle")
      .foregroundStyle(Color.grayscaleDark2)
      .pretendard(.body_S_M)
  }
  
  private var button: some View {
    RoundedButton(
      type: .solid,
      buttonText: buttonText,
      width: .maxWidth,
      action: { buttonAction?() }
    )
    
  }
}

#Preview {
  struct BottomSheetPreview: View {
    @State private var isPresented = true
    
    var body: some View {
      PCBottomSheet(
        isPresented: $isPresented,
        height: 300,
        titleText: "String",
        buttonText: "다움",
        buttonAction: { isPresented = false }
      ) {
        VStack {
          Text("Content")
            .padding()
        }
      }
    }
  }
  
  return BottomSheetPreview()
}
