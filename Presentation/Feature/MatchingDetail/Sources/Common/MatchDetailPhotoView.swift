//
//  MatchDetailPhotoView.swift
//  MatchingDetail
//
//  Created by summercat on 1/30/25.
//

import DesignSystem
import SwiftUI

struct MatchDetailPhotoView: View {
  private let uri: String
  
  init(uri: String) {
    self.uri = uri
  }
  
  var body: some View {
    ZStack {
      Dimmer()
      content
    }
  }
  
  private var content: some View {
    VStack(alignment: .center) {
      NavigationBar(
        title: "",
        titleColor: .grayscaleWhite,
        rightIcon: DesignSystemAsset.Icons.close32.swiftUIImage
      ) {
        
      }
      
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
        
      }
    }
  }
}

#Preview {
  MatchDetailPhotoView(uri: "https://www.thesprucepets.com/thmb/AyzHgPQM_X8OKhXEd8XTVIa-UT0=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-145577979-d97e955b5d8043fd96747447451f78b7.jpg")
}
