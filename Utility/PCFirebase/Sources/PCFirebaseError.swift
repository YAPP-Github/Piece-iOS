//
//  PCFirebaseError.swift
//  PCFirebase
//
//  Created by summercat on 2/18/25.
//

import Foundation

public enum PCFirebaseError: LocalizedError {
    case invalidConfiguration
    case firebaseNotInitialized
    case remoteConfigNotInitialized
    case fetchFailed
    
    public var errorDescription: String {
        switch self {
        case .invalidConfiguration:
            return "Failed to load GoogleService-Info.plist"
        case .firebaseNotInitialized:
            return "Firebase has not been initialized"
        case .remoteConfigNotInitialized:
            return "Remote Config has not been initialized"
        case .fetchFailed:
            return "Failed to fetch remote config values"
        }
    }
}
