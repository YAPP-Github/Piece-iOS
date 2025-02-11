//
//  RepositoryFactory.swift
//  Repository
//
//  Created by summercat on 2/9/25.
//

import PCNetwork
import RepositoryInterfaces

public struct RepositoryFactory {
  private let networkService: NetworkService
  
  public init(networkService: NetworkService) {
    self.networkService = networkService
  }
  
  public func createTermsRepository() -> TermsRepositoryInterfaces {
    TermsRepository(networkService: networkService)
  }
  
  public func createProfileRepository() -> ProfileRepositoryInterface {
    ProfileRepository(networkService: networkService)
  }
}
