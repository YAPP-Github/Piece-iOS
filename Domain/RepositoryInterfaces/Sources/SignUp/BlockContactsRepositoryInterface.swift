//
//  BlockContactsInterface.swift
//  RepositoryInterfaces
//
//  Created by eunseou on 2/16/25.
//

import SwiftUI
import Entities

public protocol BlockContactsRepositoryInterface {
  func postBlockContacts(phoneNumbers: BlockContactsModel) async throws -> VoidModel
}
