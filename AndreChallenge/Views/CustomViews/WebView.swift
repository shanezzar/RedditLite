//
//  WebView.swift
//  AndreChallenge
//
//  Created by Shanezzar Sharon on 24/11/2021.
//

import SwiftUI
import WebKit

struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(request: "https://www.apple.com")
    }
}

struct WebView : UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    
    // MARK:- variables
    let request: String
    
    func makeUIView(context: Context) -> WKWebView  {
        guard
            let path = Bundle.main.path(forResource: colorScheme == .dark ? "style-dark" : "style", ofType: "css"),
            let cssString = try? String(contentsOfFile: path).components(separatedBy: .newlines).joined()
        else {
            return WKWebView()
        }
        
        let source = """
        var style = document.createElement('style');
        style.innerHTML = '\(cssString)';
        document.head.appendChild(style);
        """
        
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let userContentController = WKUserContentController()
        userContentController.addUserScript(userScript)
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        configuration.dataDetectorTypes = .all
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.backgroundColor = UIColor.clear
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: request)!))
    }
    
}
