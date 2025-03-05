//
//  UserRole.swift
//  Entities
//
//  Created by summercat on 3/5/25.
//

public enum UserRole: String {
  case NONE
  case REGISTER
  case PENDING
  case USER
  
  public init(_ role: String) {
    self = UserRole(rawValue: role) ?? .NONE
  }
}
