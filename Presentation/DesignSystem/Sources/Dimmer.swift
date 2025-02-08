//
//  Dimmer.swift
//  DesignSystem
//
//  Created by summercat on 2/8/25.
//

import SwiftUI

public struct Dimmer: UIViewRepresentable {
  public init() { }
  
  public func makeUIView(context: Context) -> UIView {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    view.alpha = 0.8
    DispatchQueue.main.async {
      view.superview?.superview?.backgroundColor = .clear
    }
    return view
  }
  
  public func updateUIView(_ uiView: UIView, context: Context) {}
}
