//
//  MatchingProfileCardView.swift
//  MatchingMain
//
//  Created by eunseou on 1/4/25.
//

import SwiftUI
import DesignSystem

// MARK: - 프로필 카드
struct MatchingProfileCardView: View {
  @ObservedObject var matchingMainViewModel: MatchingMainViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      MatchingAnswer(type: .before)
      
      Spacer()
        .frame(height: 20)
      
      ProfileBasicButton(
        description: matchingMainViewModel.state.description ,
        name: matchingMainViewModel.state.name,
        age: matchingMainViewModel.state.age,
        location: matchingMainViewModel.state.location,
        job: matchingMainViewModel.state.job
      )
      
      Divider(weight: .normal, isVertical: false)
      
      HStack(spacing: 4) {
        Text("나와 같은 가치관")
        Text("\(matchingMainViewModel.state.tags.count)개")
          .foregroundColor(.primaryDefault)
      }
      .pretendard(.body_M_M)
      .foregroundColor(.grayscaleBlack)
      
      ScrollView(.vertical, showsIndicators: true) {
        VStack(alignment: .leading, spacing: 8) {
          ForEach(matchingMainViewModel.state.tags, id: \.self) { tag in
            Tag(badgeText: tag)
              .frame(maxWidth: 260, alignment: .leading)
          }
        }
        .lineLimit(2)
        .truncationMode(.tail)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.trailing)
        
        Spacer()
          .frame(height: 32)
      }
      
      Spacer()
        .frame(height: 16)
      
      RoundedButton(
        type: .solid,
        buttonText: "매칭수락하기",
        icon: nil,
        action: {
        })
    }
    .padding(.vertical, 20)
    .padding(.horizontal, 20)
    .background(
      Rectangle()
        .fill(Color.grayscaleWhite)
        .cornerRadius(16)
    )
  }
}

// MARK: - 프로필 카드 내부 버튼
private struct ProfileBasicButton: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text(description)
      Text("\(name)입니다")
    }
    .pretendard(.heading_L_SB)
    
    Spacer()
      .frame(height: 12)
    
    HStack(spacing: 8) {
      Text("\(age)년생")
      Divider(weight: .normal, isVertical: true)
        .frame(height: 12)
      Text(location)
      Divider(weight: .normal, isVertical: true)
        .frame(height: 12)
      Text(job)
    }
    .pretendard(.body_M_M)
    .foregroundColor(.grayscaleDark2)
  }
  
  let description: String
  let name: String
  let age: String
  let location: String
  let job: String
}

#Preview {
  MatchingProfileCardView(matchingMainViewModel: MatchingMainViewModel())
}
