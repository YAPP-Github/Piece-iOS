//
// NotificationListView.swift
// NotificationList
//
// Created by summercat on 2025/02/26.
//

import DesignSystem
import Router
import SwiftUI

struct NotificationListView: View {
  @State var viewModel: NotificationListViewModel
  @Environment(Router.self) private var router

  var body: some View {
    VStack(spacing: 0) {
      NavigationBar(
        title: "알림",
        leftButtonTap: {
          router.pop()
        }
      )
      
      ScrollView {
        notifications
      }
    }
    .toolbar(.hidden)
  }
  
  private var notifications: some View {
    VStack(spacing: 0) {
      ForEach(
        Array(zip(viewModel.notifications.indices, viewModel.notifications)),
        id: \.1.id
      ) { index, notification in
        NotificationItem(model: notification)
        
        if index < viewModel.notifications.count - 1 {
          Divider(weight: .normal)
        }
      }
    }
  }
}

#Preview {
  let viewModel = NotificationListViewModel(
    notifications: notifications
  )
  
  NotificationListView(viewModel: viewModel)
    .environment(Router())
}
