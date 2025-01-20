//
//  WebView.swift
//  SignUp
//
//  Created by eunseou on 1/20/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
  let urlString: String
  
  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    if let url = URL(string: urlString) {
      let request = URLRequest(url: url)
      webView.load(request)
    }
    return webView
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    if let url = URL(string: urlString), url != uiView.url {
      let request = URLRequest(url: url)
      uiView.load(request)
    }
  }
}
