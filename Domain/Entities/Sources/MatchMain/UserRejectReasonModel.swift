//
//  UserRejectReasonModel.swift
//  Entities
//
//  Created by eunseou on 2/24/25.
//

import SwiftUI

public struct UserRejectReasonModel {
  public let profileStatus: String
  public let reasonImage: Bool
  public let reasonValues: Bool
  
  public init(profileStatus: String, reasonImage: Bool, reasonValues: Bool) {
    self.profileStatus = profileStatus
    self.reasonImage = reasonImage
    self.reasonValues = reasonValues
  }
}
