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
  
  public func createUserRepository() -> UserRepositoryInterface {
    UserRepository(networkService: networkService)
  }
  
  public func createLoginRepository() -> LoginRepositoryInterface {
    LoginRepository(networkService: networkService)
  }
  
  public func createTermsRepository() -> TermsRepositoryInterfaces {
    TermsRepository(networkService: networkService)
  }
  
  public func createCheckNicknameRepository() -> CheckNinknameRepositoryInterface {
    CheckNicknameRepository(networkService: networkService)
  }
  
  public func createUploadProfileImageRepository() -> ProfileRepositoryInterface {
    ProfileRepository(networkService: networkService)
  }
  
  public func createBlockContactsRepository() -> BlockContactsRepositoryInterface {
    BlockContactsRepository(networkService: networkService)
  }
  
  public func createProfileRepository() -> ProfileRepositoryInterface {
    ProfileRepository(networkService: networkService)
  }
  
  public func createValueTalksRepository() -> ValueTalksRepositoryInterface {
    ValueTalksRepository(networkService: networkService)
  }
  
  public func createValuePicksRepository() -> ValuePicksRepositoryInterface {
    ValuePicksRepository(networkService: networkService)
  }
  
  public func createMatchesRepository() -> MatchesRepositoryInterface {
    MatchesRepository(networkService: networkService)
  }
  
  public func createReportsRepository() -> ReportsRepositoryInterface {
    ReportsRepository(networkService: networkService)
  }

  public func createSseRepository() -> SSERepositoryInterface {
    SSERepository(networkService: networkService)
  }
  
  public func createSettingsRepository() -> SettingsRepositoryInterface {
    SettingsRepository(networkService: networkService)
  }
}
