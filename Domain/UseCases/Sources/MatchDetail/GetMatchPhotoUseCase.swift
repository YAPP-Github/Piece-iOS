//
//  GetMatchPhotoUseCase.swift
//  UseCases
//
//  Created by summercat on 2/6/25.
//

public protocol GetMatchPhotoUseCase {
  func execute() async throws -> String
}

final class GetMatchPhotoUseCaseImpl: GetMatchPhotoUseCase {
  func execute() async throws -> String {
    // TODO: - 네트워크 붙이고 수정
    return "https://www.thesprucepets.com/thmb/AyzHgPQM_X8OKhXEd8XTVIa-UT0=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-145577979-d97e955b5d8043fd96747447451f78b7.jpg"
  }
}
