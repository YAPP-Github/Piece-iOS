//
//  MatchStatus.swift
//  Entities
//
//  Created by eunseou on 4/5/25.
//

import SwiftUI

public enum MatchStatus: String {
  case BEFORE_OPEN
  case WAITING
  case RESPONDED
  case GREEN_LIGHT
  case MATCHED
  
  public init(_ status: String) {
    self = MatchStatus(rawValue: status) ?? .BEFORE_OPEN
  }
}
