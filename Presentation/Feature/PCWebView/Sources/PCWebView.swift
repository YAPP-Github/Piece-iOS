//
//  PCWebView.swift
//  PCWebView
//
//  Created by eunseou on 1/20/25.
//

import SwiftUI
import WebKit

public struct PCWebView: UIViewRepresentable {
  let uri: String
  
  public init(uri: String) {
    self.uri = uri
  }
  
  public func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    if let url = URL(string: uri) {
      let request = URLRequest(url: url)
      webView.load(request)
    }
    return webView
  }
  
  public func updateUIView(_ uiView: WKWebView, context: Context) {
    if let url = URL(string: uri), url != uiView.url {
      let request = URLRequest(url: url)
      uiView.load(request)
    }
  }
}
