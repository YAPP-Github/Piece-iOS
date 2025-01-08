//
//  MatchingMainView.swift
//  MatchingMain
//
//  Created by eunseou on 12/28/24.
//

import SwiftUI
import DesignSystem

struct MatchingMainView: View {
  @Bindable var matchingTimerViewModel: MatchingTimerViewModel
  @Bindable var matchingMainViewModel: MatchingMainViewModel
  
  public var body: some View {
    ZStack {
      Color.grayscaleBlack.edgesIgnoringSafeArea(.all)
      VStack {
        MatchingTimer(matchingTimerViewModel: matchingTimerViewModel)
        VStack(alignment: .leading) {
          MatchingAnswer(type: matchingMainViewModel.matchingStatus)
          
          Spacer()
            .frame(height: 20)
          
          Button {
            matchingMainViewModel.handleAction(.tapProfileInfo)
          } label: {
            ProfileInfo
          }
          
          HStack(spacing: 4) {
            Text("나와 같은 가치관")
            Text("\(matchingMainViewModel.tags.count)개")
              .foregroundColor(.primaryDefault)
          }
          .pretendard(.body_M_M)
          .foregroundColor(.grayscaleBlack)
          
          Divider(weight: .normal, isVertical: false)
          
          Tags
          
          Spacer()
            .frame(height: 16)
          
          SummitButton
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(
          Rectangle()
            .fill(Color.grayscaleWhite)
            .cornerRadius(16)
        )
      }
      .padding(.horizontal, 20)
    }
  }
  
  private var ProfileInfo: some View {
    VStack(alignment: .leading) {
      VStack(alignment: .leading) {
        Text(matchingMainViewModel.description)
        Text("\(matchingMainViewModel.name)입니다")
      }
      .pretendard(.heading_L_SB)
      .foregroundStyle(Color.grayscaleBlack)
      
      Spacer()
        .frame(height: 12)
      
      HStack(spacing: 8) {
        Text("\(matchingMainViewModel.age)년생")
        Divider(weight: .normal, isVertical: true)
          .frame(height: 12)
        Text(matchingMainViewModel.location)
        Divider(weight: .normal, isVertical: true)
          .frame(height: 12)
        Text(matchingMainViewModel.job)
      }
      .pretendard(.body_M_M)
      .foregroundStyle(Color.grayscaleDark2)
    }
  }
  
  private var Tags: some View {
    ScrollView(.vertical, showsIndicators: true) {
      VStack(alignment: .leading, spacing: 8) {
        ForEach(matchingMainViewModel.tags, id: \.self) { tag in
          Tag(badgeText: tag)
            .frame(maxWidth: 260, alignment: .leading)
            .lineLimit(2)
            .truncationMode(.tail)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Spacer()
        .frame(height: 32)
    }
  }
  
  private var SummitButton: some View {
    RoundedButton(
      type: .solid,
      buttonText: matchingMainViewModel.buttonTitle,
      icon: nil,
      action: {
        matchingMainViewModel.handleAction(.acceptMatching)
      })
  }
}

#Preview {
  MatchingMainView(
    matchingTimerViewModel: MatchingTimerViewModel(),
    matchingMainViewModel: MatchingMainViewModel(
      description: "[나를 표현하는 한마디]",
      name: "[닉네임]",
      age: "02",
      location: "대구광역시",
      job: "학생",
      tags: [
        "바깥 데이트 스킨십도 가능",
        "함께 술을 즐기고 싶어요",
        "커밍아웃은 가까운 친구에게만 했어요",
        "연락은 바쁘더라도 자주",
        "최대 너비 260. 두 줄 노출 가능. 최대 너비 260. 두 줄 노출 가능.",
        "최대 너비 260. 두 줄 노출 가능. 최대 너비 260. 두 줄 노출 가능.",
        "최대 너비 260. 두 줄 노출 가능. 최대 너비 260. 두 줄 노출 가능.",
        "최대 너비 260. 두 줄 노출 가능. 최대 너비 260. 두 줄 노출 가능."
      ],
      buttonTitle: "매칭 수락하기",
      matchingStatus: .before
    )
  )
}
