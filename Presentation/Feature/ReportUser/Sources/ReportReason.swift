//
//  ReportReason.swift
//  ReportUser
//
//  Created by summercat on 2/16/25.
//

enum ReportReason: String, CaseIterable, Identifiable {
  case inappropriateContent = "소개글에서 불쾌감을 느꼈어요."
  case fakeProfile = "프로필에 거짓이 포함되어 있어요."
  case badIntention = "부적절한 만남을 추구하고 있어요."
  case other = "기타"
  
  var id: String { self.rawValue }
}
