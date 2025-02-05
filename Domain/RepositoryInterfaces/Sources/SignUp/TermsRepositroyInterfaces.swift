//
//  TermRepositroyInterfaces.swift
//  RepositoryInterfaces
//
//  Created by eunseou on 2/5/25.
//

import Foundation
import Entities

public protocol TermsRepositoryInterfaces {
  func fetchTermList() async throws -> TermsListModel
}
