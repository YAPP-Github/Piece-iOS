//
//  MatchDetailPhotoView.swift
//  MatchingDetail
//
//  Created by summercat on 1/30/25.
//

import DesignSystem
import Router
import SwiftUI

struct MatchDetailPhotoView: View {
  private let nickname: String
  private let uri: String
  @Environment(Router.self) private var router: Router
  @Environment(\.dismiss) private var dismiss
  @State private var isAlertPresented: Bool = false
  
  init(
    nickname: String,
    uri: String
  ) {
    self.nickname = nickname
    self.uri = uri
  }
  
  var body: some View {
    content
      .background(
        Dimmer()
          .ignoresSafeArea()
      )
  }
  
  private var content: some View {
    VStack(alignment: .center) {
      NavigationBar(
        title: "",
        titleColor: .grayscaleWhite,
        rightButton: Button { dismiss() } label: {DesignSystemAsset.Icons.close32.swiftUIImage }
      )
      
      Spacer()
      
      AsyncImage(url: URL(string: uri)) { image in
        image.image?
          .resizable()
          .scaledToFill()
      }
      .frame(width: 180, height: 180)
      .clipShape(Circle())
      
      Spacer()
      
      RoundedButton(
        type: .solid,
        buttonText: "매칭 수락하기",
        rounding: true
      ) {
        isAlertPresented.toggle()
      }
    }
    .pcAlert(isPresented: $isAlertPresented) {
      AlertView(
        title: {
          Text("\(nickname)").foregroundStyle(Color.primaryDefault) +
          Text("님과의\n인연을 이어가시겠습니까?").foregroundStyle(Color.grayscaleBlack)
        },
        message: "서로 매칭을 수락하면, 연락처가 공개됩니다.",
        firstButtonText: "뒤로",
        secondButtonText: "매칭 수락하기"
      ) {
        isAlertPresented = false
      } secondButtonAction: {
        dismiss()
        router.popToRoot()
      }
    }
  }
}

#Preview {
  let uri = "https://www.thesprucepets.com/thmb/AyzHgPQM_X8OKhXEd8XTVIa-UT0=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-145577979-d97e955b5d8043fd96747447451f78b7.jpg"
  MatchDetailPhotoView(nickname: "티모대위", uri: uri)
    .environment(Router())
}
