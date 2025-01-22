//
//  CameraPermissionUseCase.swift
//  UseCase
//
//  Created by eunseou on 1/21/25.
//

import Foundation
import AVFoundation

public protocol RequestCameraUseCase {
  func execute() async -> Bool
}

public final class RequestCameraUseCaseImplementation: RequestCameraUseCase {
  private let captureDevice: AVCaptureDevice.Type
  
  public init(captureDevice: AVCaptureDevice.Type = AVCaptureDevice.self) {
    self.captureDevice = captureDevice
  }
  
  public func execute() async -> Bool {
    let status = AVCaptureDevice.authorizationStatus(for: .video)
    
    switch status {
    case .authorized:
      return true
    case .notDetermined:
      return await captureDevice.requestAccess(for: .video)
    default:
      return false
    }
  }
}
