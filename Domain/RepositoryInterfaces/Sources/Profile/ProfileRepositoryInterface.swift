//
//  ProfileRepositoryInterface.swift
//  UseCases
//
//  Created by summercat on 2/9/25.
//

import Entities
import SwiftUI

public protocol ProfileRepositoryInterface {
  func postProfile(_ profile: ProfileModel) async throws -> PostProfileResultModel
  func uploadProfileImage(_ imageData: Data) async throws -> URL
  func getProfileValuePicks() async throws -> [ValuePickModel]
  func updateProfileValuePicks(_ valuePicks: [ValuePickModel]) async throws -> VoidModel
}
