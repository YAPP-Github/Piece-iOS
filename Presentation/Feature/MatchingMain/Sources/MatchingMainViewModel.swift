//
//  MatchingMainViewModel.swift
//  MatchingMain
//
//  Created by eunseou on 1/4/25.
//

import SwiftUI
import Observation

@Observable
final class MatchingMainViewModel {
    private enum Constant {
        static let defaultDescription = "[나를 표현하는 한마디]"
        static let defaultName = "[닉네임]"
        static let defaultAge = "02"
        static let defaultLocation = "대구광역시"
        static let defaultJob = "학생"
        static let defaultTags = [
            "바깥 데이트 스킨십도 가능",
            "함께 술을 즐기고 싶어요",
            "커밍아웃은 가까운 친구에게만 했어요",
            "연락은 바쁘더라도 자주",
            "최대 너비 260. 두 줄 노출 가능. 최대 너비 260. 두 줄 노출 가능."
        ]
    }
    
    enum Action {
        case fetchProfile
    }
    
    private(set) var description: String
    private(set) var name: String
    private(set) var age: String
    private(set) var location: String
    private(set) var job: String
    private(set) var tags: [String]
    
    init(
        description: String = Constant.defaultDescription,
        name: String = Constant.defaultName,
        age: String = Constant.defaultAge,
        location: String = Constant.defaultLocation,
        job: String = Constant.defaultJob,
        tags: [String] = Constant.defaultTags
    ) {
        self.description = description
        self.name = name
        self.age = age
        self.location = location
        self.job = job
        self.tags = tags
    }
    
    func handleAction(_ action: Action) {
        switch action {
        case .fetchProfile:
            fetchProfile()
        }
    }
    
    private func fetchProfile() {
        description = Constant.defaultDescription
        name = Constant.defaultName
        age = Constant.defaultAge
        location = Constant.defaultLocation
        job = Constant.defaultJob
        tags = Constant.defaultTags
    }
}
