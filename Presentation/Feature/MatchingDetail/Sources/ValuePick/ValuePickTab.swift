//
//  ValuePickTab.swift
//  MatchingDetail
//
//  Created by summercat on 1/14/25.
//

enum ValuePickTab: CaseIterable, Identifiable {
  case all
  case same
  case different
  
  var id: String {
    return self.description
  }
  
  var description: String {
    switch self {
    case .all: "전체"
    case .same: "나와 같은"
    case .different: "나와 다른"
    }
  }
}
