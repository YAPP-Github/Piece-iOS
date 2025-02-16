//
//  PCLottieView.swift
//  DesignSystem
//
//  Created by summercat on 2/16/25.
//

import Lottie
import SwiftUI

public struct PCLottieView: View {
  private let animation: Lotties
  private let loopMode: LottieLoopMode
  private let width: CGFloat?
  private let height: CGFloat?
  
  public init(
    _ animation: Lotties,
    loopMode: LottieLoopMode = .loop,
    width: CGFloat? = nil,
    height: CGFloat? = nil
  ) {
    self.animation = animation
    self.loopMode = loopMode
    self.width = width
    self.height = height
  }
  
  public var body: some View {
    LottieView(animation: .named(animation.name, bundle: Bundle.module))
      .playing(loopMode: loopMode)
      .frame(width: width ?? nil, height: height ?? nil)
  }
}

#Preview {
  VStack {
    PCLottieView(.aiSummaryLarge)
    PCLottieView(.aiSummaryLarge, width: 100, height: 100)
  }
}
