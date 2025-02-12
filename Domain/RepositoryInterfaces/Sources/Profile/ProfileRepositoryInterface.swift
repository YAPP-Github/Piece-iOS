//
//  ProfileRepositoryInterface.swift
//  UseCases
//
//  Created by summercat on 2/9/25.
//

import Entities

public protocol ProfileRepositoryInterface {
  func postProfile(_ profile: ProfileModel) async throws -> PostProfileResultModel
  func getProfileValuePicks() async throws -> [ValuePickModel]
}
