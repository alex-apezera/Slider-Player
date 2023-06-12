//
//  WebView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 12.06.2025.
//
// From "Взаимодействие SwiftUI с вебом." Proglib.io

import SwiftUI
import Combine
import WebKit

struct WebView: UIViewRepresentable {
    var type: URLType
    var url: String?
    
    @ObservedObject var viewModel: WebViewModel
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        
        configuration.preferences = preferences
        configuration.userContentController.add(context.coordinator, contentWorld: .page, name: "messageAppHandler")

        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let urlValue = url  {
            if type == .local {
                if let localUrl = Bundle.main.url(forResource: urlValue, withExtension: "html", subdirectory: "www") {
                    webView.loadFileURL(localUrl, allowingReadAccessTo: localUrl.deletingLastPathComponent())
                }
            } else if type == .public {
                if let requestUrl = URL(string: urlValue) {
                    webView.load(URLRequest(url: requestUrl))
                }
            }
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        var webViewNavigationSubscriber: AnyCancellable? = nil
        
        init(_ webView: WebView) {
            self.parent = webView
        }
        
        deinit {
            webViewNavigationSubscriber?.cancel()
        }
//MARK: - optional functions webView
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("didFinish")
            self.parent.viewModel.isLoaderVisible.send(false)

            webView.evaluateJavaScript(getHeaderTitle, in: nil, in: .defaultClient) { result in
                switch result {
                    case .success(let value):
                        if let title = value as? String {
                            self.parent.viewModel.webTitle.send(title)
                        }
                    case .failure(let error):
                        print(error)
                    }
                }

            webView.evaluateJavaScript("document.title") { (response, error) in
                if let error = error {print(error)}
                guard let title = response as? String else {return}
                self.parent.viewModel.webTitle.send(title)
            }
            
            webView.evaluateJavaScript(hideHeaderTitle, in: nil, in: .defaultClient)
            
            webView.callAsyncJavaScript(hideAnyElement, arguments: ["selector":"#ok"], in: nil, in: .defaultClient)
            
            let timeout = 3000;
            webView.callAsyncJavaScript(setTimeoutFor, arguments: [ "timeout":"\(timeout)"], in: nil, in: .defaultClient) { (result) in
                switch result {
                case .success(let response):
                    print("Done...");
                    print(response);
                case .failure(let error):
                    print("Error...");
                    print(error)
                }
            }
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("didStartProvisionalNavigation")
            self.parent.viewModel.isLoaderVisible.send(true)
            self.webViewNavigationSubscriber = self.parent.viewModel.webViewNavigationPublisher.receive(on: RunLoop.main).sink(receiveValue: { navigation in
                switch navigation {
                    case .backward:
                        if webView.canGoBack {
                            webView.goBack()
                        }
                    case .forward:
                        if webView.canGoForward {
                            webView.goForward()
                        }
                    case .reload:
                        webView.reload()
                }
            })
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("didFailProvisionalNavigation")
            self.parent.viewModel.isLoaderVisible.send(false)
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            print("didCommit")
            self.parent.viewModel.isLoaderVisible.send(true)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("didFail")
            self.parent.viewModel.isLoaderVisible.send(false)
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
            print("decidePolicyFor")
            decisionHandler(.allow, preferences)
        }
        
        func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
            print("didReceiveServerRedirectForProvisionalNavigation")
        }
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            print("webViewWebContentProcessDidTerminate")
            self.parent.viewModel.isLoaderVisible.send(false)
        }
//MARK: - end optionals
    }///Coordinator

}

extension WebView.Coordinator: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "messageAppHandler" {
            if let body = message.body as? String {
                print("Message body: \(body)")
            }
        }
    }
}

