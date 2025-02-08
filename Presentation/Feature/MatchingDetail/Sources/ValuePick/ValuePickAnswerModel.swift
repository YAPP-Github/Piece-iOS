//
//  ValuePickAnswerModel.swift
//  MatchingDetail
//
//  Created by summercat on 1/13/25.
//

import Foundation

struct ValuePickAnswerModel: Identifiable {
  let id: UUID
  let category: String
  let question: String
  let sameWithMe: Bool
}
