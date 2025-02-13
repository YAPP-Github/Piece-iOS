//
//  ProfileValueTalkModel.swift
//  Entities
//
//  Created by summercat on 2/13/25.
//

public struct ProfileValueTalkModel {
  public let profileValueTalkId: Int
  public let title: String
  public let category: String
  public let summary: String
  public let answer: String
  
  public init(
    profileValueTalkId: Int,
    title: String,
    category: String,
    summary: String,
    answer: String
  ) {
    self.profileValueTalkId = profileValueTalkId
    self.title = title
    self.category = category
    self.summary = summary
    self.answer = answer
  }
}
