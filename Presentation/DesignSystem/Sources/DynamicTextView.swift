//
//  DynamicHeightTextView.swift
//  DesignSystem
//
//  Created by eunseou on 2/1/25.
//

import SwiftUI
import UIKit

public struct DynamicTextView: UIViewRepresentable {
  @Binding var text: String
  
  public func makeUIView(context: Context) -> UITextView {
    let textView = UITextView()
    textView.delegate = context.coordinator
    textView.isScrollEnabled = false
    textView.font = UIFont.systemFont(ofSize: 16)
    textView.textContainer.lineBreakMode = .byWordWrapping
    textView.textContainerInset = .zero
    textView.textContainer.lineFragmentPadding = 0
    textView.backgroundColor = .clear
    textView.translatesAutoresizingMaskIntoConstraints = false
    
    textView.widthAnchor.constraint(equalToConstant: 243).isActive = true
    textView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    
    return textView
  }
  
  public func updateUIView(_ uiView: UITextView, context: Context) {
    uiView.text = text
    context.coordinator.adjustHeight(textView: uiView)
  }
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  public class Coordinator: NSObject, UITextViewDelegate {
    var parent: DynamicTextView
    
    init(_ parent: DynamicTextView) {
      self.parent = parent
    }
    
    public func textViewDidChange(_ textView: UITextView) {
      parent.text = textView.text
      adjustHeight(textView: textView)
    }
    
    func adjustHeight(textView: UITextView) {
      let maxWidth: CGFloat = 243
      let maxLines = 3
      let lineHeight = textView.font?.lineHeight ?? 24
      
      let size = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
      let estimatedSize = textView.sizeThatFits(size)
      
      let numberOfLines = min(Int(estimatedSize.height / lineHeight), maxLines)
      let newHeight = CGFloat(numberOfLines) * lineHeight
      
      textView.constraints.forEach { constraint in
        if constraint.firstAttribute == .height {
          constraint.constant = newHeight
        }
      }
      
      if textView.constraints.filter({ $0.firstAttribute == .height }).isEmpty {
        textView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
      }
      
      textView.textContainer.size = CGSize(width: maxWidth, height: newHeight)
      textView.textContainer.maximumNumberOfLines = maxLines
      textView.textContainer.lineBreakMode = .byWordWrapping
    }
  }
}
