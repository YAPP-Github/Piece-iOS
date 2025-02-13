//
//  SettingsInformationSectionView.swift
//  Settings
//
//  Created by summercat on 2/12/25.
//

import SwiftUI
import DesignSystem

struct SettingsInformationSectionView: View {
  let title: String
  @Binding var termsItems: [SettingsTermsItem]
  let version: String
  
  let didTapNoticeItem: () -> Void
  let didTapTermsItem: (Int) -> Void
  
  var body: some View {
    VStack(spacing: 8) {
      SettingsSectionHeaderTitleView(title: title)
      VStack(spacing: 0) {
        SettingChevronView(title: "공지사항")
          .onTapGesture {
            didTapNoticeItem()
          }
        ForEach(termsItems, id: \.id) { terms in
          SettingChevronView(title: terms.title)
            .onTapGesture {
              didTapTermsItem(terms.id)
            }
        }
        SettingsTextItemView(title: version, textColor: Color.grayscaleDark3)
      }
    }
  }
}
