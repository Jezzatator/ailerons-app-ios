//
//  WebView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 22/01/2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let urlString: String
    
    let webView: WKWebView = WKWebView(frame: .zero)
       
       func makeUIView(context: Context) -> WKWebView {
           return webView
       }
       func updateUIView(_ uiView: WKWebView, context: Context) {
           webView.load(URLRequest(url: URL(string: urlString)!))
       }
}


