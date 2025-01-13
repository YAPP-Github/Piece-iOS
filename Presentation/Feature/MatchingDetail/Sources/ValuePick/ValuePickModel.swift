//
//  ValuePickModel.swift
//  MatchingDetail
//
//  Created by summercat on 1/13/25.
//

struct ValuePickModel: Identifiable {
  let id: Int
  let category: String
  let question: String
  let answers: [ValuePickAnswerModel]
  let isSame: Bool
}
