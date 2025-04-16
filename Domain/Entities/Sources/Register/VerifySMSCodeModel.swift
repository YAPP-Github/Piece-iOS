//
//  VerifySMSCodeModel.swift
//  Entities
//
//  Created by eunseou on 2/15/25.
//

import SwiftUI

public struct VerifySMSCodeModel {
  public let phoneNumber: String
  public let code: String
  
  public init(
    phoneNumber: String,
    code: String
  ) {
    self.phoneNumber = phoneNumber
    self.code = code
  }
}
