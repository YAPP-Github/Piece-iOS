//
//  GetProfileUseCase.swift
//  UseCases
//
//  Created by summercat on 1/30/25.
//

import Entities

public protocol GetProfileUseCase {
  func execute() async throws -> ProfileModel
}

final class GetProfileUseCaseImpl: GetProfileUseCase {
  func execute() async throws -> ProfileModel {
    // TODO: - 네트워크 모듈 작업 후 수정
    return ProfileModel(
      nickname: "닉네임",
      description: "소개글",
      age: 25,
      birthdate: "00",
      height: 180,
      weight: 72,
      job: "프리랜서",
      location: "세종특별자치시",
      smokingStatus: "비흡연",
      snsActivityLevel: "",
      imageUrl: "https://www.thesprucepets.com/thmb/AyzHgPQM_X8OKhXEd8XTVIa-UT0=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-145577979-d97e955b5d8043fd96747447451f78b7.jpg"
    )
  }
}
