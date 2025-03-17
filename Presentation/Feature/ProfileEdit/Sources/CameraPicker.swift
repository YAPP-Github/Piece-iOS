//
//  CameraPicker.swift
//  ProfileEdit
//
//  Created by eunseou on 3/15/25.
//

import SwiftUI
import UIKit

public struct CameraPicker: UIViewControllerRepresentable {
  @Environment(\.presentationMode) private var presentationMode
  var onImagePicked: (UIImage) -> Void
  
  public func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.sourceType = .camera
    picker.delegate = context.coordinator
    picker.allowsEditing = true
    return picker
  }
  
  public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    
  }
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: CameraPicker
    
    init(_ parent: CameraPicker) {
      self.parent = parent
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
        parent.onImagePicked(image)
      }
      parent.presentationMode.wrappedValue.dismiss()
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      parent.presentationMode.wrappedValue.dismiss()
    }
  }
}

