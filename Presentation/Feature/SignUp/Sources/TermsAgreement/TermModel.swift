//
//  TermModel.swift
//  SignUp
//
//  Created by eunseou on 1/16/25.
//

import SwiftUI

struct TermModel: Identifiable, Hashable {
  let id: Int
  let title: String
  let url: String
  let required: Bool
  var isChecked: Bool
}
