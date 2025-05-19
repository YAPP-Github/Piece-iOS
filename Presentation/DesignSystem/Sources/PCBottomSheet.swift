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
public protocol BottomSheetItemRepresentable: Hashable, Identifiable {
  associatedtype Body: View
  @ViewBuilder func render() -> Body
  
  var id: UUID { get }
  var text: String { get }
  var state: BottomSheetItemState { get }
}

public enum BottomSheetItemState {
  case selected
  case unselected
  case disable
  
  var foregroundColor: Color {
    switch self {
    case .selected:
      Color.primaryDefault
    case .unselected:
      Color.grayscaleBlack
    case .disable:
      Color.grayscaleDark3
    }
  }
}

public struct BottomSheetIconItem: BottomSheetItemRepresentable {
  public var id: UUID = UUID()
  public var text: String
  public var state: BottomSheetItemState = .unselected
  public var icon: String
  
  public func render() -> some View {
    HStack {
      DesignSystemImages(name: icon).swiftUIImage
        .renderingMode(.template)
        .foregroundStyle(state.foregroundColor)
      Text(text)
        .pretendard(.body_M_M)
        .foregroundStyle(state.foregroundColor)
      Spacer()
      if state != .unselected {
        DesignSystemAsset.Icons.check24.swiftUIImage
          .renderingMode(.template)
          .foregroundStyle(state.foregroundColor)
      }
    }
    .frame(maxWidth: .infinity)
  }
  
  public init(
    id: UUID = UUID(),
    text: String,
    state: BottomSheetItemState = .unselected,
    icon: String
  ) {
    self.id = id
    self.text = text
    self.state = state
    self.icon = icon
  }
}

extension BottomSheetIconItem {
  public static let defaultContactItems: [BottomSheetIconItem] = [
    .init(text: "카카오톡 아이디", icon: "kakao-32"),
    .init(text: "카카오톡 오픈 채팅방", icon: "kakao-openchat-32"),
    .init(text: "인스타 아이디", icon: "instagram-32"),
    .init(text: "전화번호", icon: "cell-fill-32")
  ]
}

public struct BottomSheetTextItem: BottomSheetItemRepresentable {
  public var id: UUID
  public var text: String
  public var state: BottomSheetItemState = .unselected
  
  public func render() -> some View {
    HStack {
      Text(text)
        .pretendard(.body_M_M)
        .foregroundStyle(state.foregroundColor)
      Spacer()
      if state == .selected {
        DesignSystemAsset.Icons.check24.swiftUIImage
          .renderingMode(.template)
          .foregroundStyle(state.foregroundColor)
      }
    }
    .frame(maxWidth: .infinity)
  }
  
  public init(
    id: UUID = UUID(),
    text: String,
    state: BottomSheetItemState = .unselected
  ) {
    self.id = id
    self.text = text
    self.state = state
  }
}

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
    Text(subtitleText ?? "")
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
        subtitleText: "subtitle",
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
