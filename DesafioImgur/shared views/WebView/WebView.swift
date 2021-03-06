import Combine
import SwiftUI
import WebKit
struct WebView: UIViewRepresentable {
  
  @ObservedObject var webViewModel: WebViewModel
  var onRedirectEvent: ((_ currentUrl: URL?) -> Void)? = nil
  
  func makeCoordinator() -> WebView.Coordinator {
    Coordinator(self, webViewModel)
  }
  
  func makeUIView(context: Context) -> WKWebView {
    guard let url = URL(string:  webViewModel.url) else {
      return WKWebView()
    }
    let request = URLRequest(url: url)
    let webView = WKWebView()
    let preferences = WKWebpagePreferences()
    preferences.allowsContentJavaScript = true
    webView.configuration.defaultWebpagePreferences =  preferences
    webView.navigationDelegate = context.coordinator
    webView.load(request)
    return webView
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    if webViewModel.shouldGoBack {
      uiView.goBack()
      webViewModel.shouldGoBack = false
    }
    
  }
}

extension WebView {
  class Coordinator: NSObject, WKNavigationDelegate {
    @ObservedObject private var webViewModel: WebViewModel
    private let parent: WebView
    
    init(_ parent: WebView, _ webViewModel: WebViewModel) {
      self.parent = parent
      self.webViewModel = webViewModel
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      webViewModel.isLoading = true
    }
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      webViewModel.isLoading = false
      webViewModel.title = webView.title ?? ""
      webViewModel.canGoBack = webView.canGoBack
    }
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
      self.parent.onRedirectEvent?(webView.url)
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
      webViewModel.isLoading = false
    }
  }
}
