//
//  ValuePickModel.swift
//  MatchingDetail
//
//  Created by summercat on 1/13/25.
//

struct ValuePickModel: Identifiable {
  let id: Int
  let shortIntroduction: String
  let nickname: String
  let valuePicks: [ValuePickAnswerModel]
}
