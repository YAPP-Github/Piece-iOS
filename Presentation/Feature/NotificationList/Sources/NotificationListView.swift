//
// NotificationListView.swift
// NotificationList
//
// Created by summercat on 2025/02/26.
//

import DesignSystem
import Router
import SwiftUI
import UseCases

struct NotificationListView: View {
  @State var viewModel: NotificationListViewModel
  @Environment(Router.self) private var router
  
  init(getNotificationsUseCase: GetNotificationsUseCase) {
    _viewModel = .init(wrappedValue: .init(getNotificationsUseCase: getNotificationsUseCase))
  }

  var body: some View {
    VStack(spacing: 0) {
      NavigationBar(
        title: "알림",
        leftButtonTap: {
          router.pop()
        }
      )
      Divider(weight: .normal)
      content
    }
    .toolbar(.hidden)
    .background(.grayscaleWhite)
  }
  
  @ViewBuilder
  private var content: some View {
    if viewModel.notifications.isEmpty {
      noData
    } else {
      ScrollView {
        notifications
      }
    }
  }
  
  private var noData: some View {
    VStack(spacing: 0) {
      DesignSystemAsset.Images.imgNotice.swiftUIImage
        .resizable()
        .frame(width: 240, height: 240)
      Text("받은 알림이 없어요")
        .pretendard(.heading_S_M)
        .foregroundStyle(.grayscaleDark2)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
  }
  
  private var notifications: some View {
    LazyVStack(spacing: 0) {
      ForEach(
        Array(zip(viewModel.notifications.indices, viewModel.notifications)),
        id: \.1.id
      ) { index, notification in
        NotificationItem(model: notification)
          .onAppear {
            if index == viewModel.notifications.count - 1 {
              viewModel.handleAction(.loadNotifications)
            }
          }
        
        if index < viewModel.notifications.count - 1 {
          Divider(weight: .normal)
        }
      }
    }
  }
}

//#Preview {
//  let viewModel = NotificationListViewModel(
//    notifications: notifications
//  )
//  
//  NotificationListView(viewModel: viewModel)
//    .environment(Router())
//}
