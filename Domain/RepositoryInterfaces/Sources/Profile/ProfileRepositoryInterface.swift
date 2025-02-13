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
  func getProfileValueTalks() async throws -> [ProfileValueTalkModel]
  func getProfileValuePicks() async throws -> [ProfileValuePickModel]
  func updateProfileValuePicks(_ valuePicks: [ProfileValuePickModel]) async throws -> VoidModel
}
