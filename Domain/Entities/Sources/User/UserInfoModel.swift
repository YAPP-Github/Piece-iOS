//
//  UserInfoModel.swift
//  Entities
//
//  Created by summercat on 3/5/25.
//

public struct UserInfoModel {
  public let id: Int
  public let role: UserRole
  public let profileStatus: ProfileStatus?
  
  public init(id: Int, role: UserRole, profileStatus: ProfileStatus?) {
    self.id = id
    self.role = role
    self.profileStatus = profileStatus
  }
}
