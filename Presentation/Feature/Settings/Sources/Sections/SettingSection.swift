//
//  SettingSection.swift
//  Settings
//
//  Created by summercat on 2/12/25.
//

struct SettingSection: Identifiable {
  let id: SettingSectionID
  var title: String { id.title }
}
