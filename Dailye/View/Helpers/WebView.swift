import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable{
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else{
            return WKWebView()
        }
        let request = URLRequest(url: url)
        let view = WKWebView()
        view.load(request)
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
            
    }
}
