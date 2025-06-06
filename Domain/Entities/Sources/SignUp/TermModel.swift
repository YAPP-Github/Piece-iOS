//
//  TermModel.swift
//  Entities
//
//  Created by 홍승완 on 6/6/25.
//

import Foundation

@Observable
public class TermModel: Identifiable, Hashable {
  public let id: Int
  public let title: String
  public let url: String
  public let required: Bool
  public private(set) var isChecked: Bool
  
  public init(
    id: Int,
    title: String,
    url: String,
    required: Bool,
    isChecked: Bool
  ) {
    self.id = id
    self.title = title
    self.url = url
    self.required = required
    self.isChecked = isChecked
  }
  
  // MARK: - Hashable

  public static func == (lhs: TermModel, rhs: TermModel) -> Bool {
    return lhs.id == rhs.id
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

