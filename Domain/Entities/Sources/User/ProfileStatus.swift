//
//  ProfileStatus.swift
//  Entities
//
//  Created by summercat on 3/5/25.
//

public enum ProfileStatus: String {
  case INCOMPLETE
  case REJECTED
  case REVISED
  case APPROVED
  
  public init(_ status: String) {
    self = ProfileStatus(rawValue: status) ?? .INCOMPLETE
  }
}
