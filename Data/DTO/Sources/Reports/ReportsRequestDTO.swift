//
//  ReportsRequestDTO.swift
//  DTO
//
//  Created by summercat on 5/1/25.
//

public struct ReportsRequestDTO: Encodable {
  public let reportedUserId: Int
  public let reason: String
  
  public init(
    reportedUserId: Int,
    reason: String
  ) {
    self.reportedUserId = reportedUserId
    self.reason = reason
  }
}
