//
//  ProfileValueTalkSummaryRequestDTO.swift
//  DTO
//
//  Created by summercat on 2/16/25.
//

import Foundation

public struct ProfileValueTalkSummaryRequestDTO: Encodable {
  public let summary: String
  
  public init(summary: String) {
    self.summary = summary
  }
}
