//
//  CookieWKWebViewController.swift
//  wkwebviewCookie
//
//  Created by shiqi sun on 2019/1/10.
//  Copyright © 2019 denty. All rights reserved.
//

import UIKit
import WebKit
import Dispatch

class CookieWKWebViewController: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    var jumpUrl:String! = "";
    var processPool:WKProcessPool?
    var wkwebview: WKWebView?
    override func viewDidLoad() {
        super.viewDidLoad()
        requestSetCookie()
        closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }
    
    @objc func closeAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    func requestSetCookie() -> Void {
        if let setCookieUrl:URL = URL.init(string: "http://127.0.0.1:2019/server/setCookie") {
            let urlRequest:URLRequest = URLRequest.init(url: setCookieUrl)
            let sessionTask:URLSessionTask = URLSession.shared.dataTask(with: urlRequest) { (data:Data?, urlRespones:URLResponse?, err:Error?) in
                NSLog("success")
                DispatchQueue.main.async {
                    self.setupWKWebView()
                }
            }
            sessionTask.resume()
        }
    }
    
    func injectCookie() -> WKUserScript {
        var cookieString:String = "";
        let cookies:[HTTPCookie] = HTTPCookieStorage.shared.cookies ?? []
        cookies.forEach { (cookie) in
            cookieString = cookieString + String.init(format: "document.cookie = '%@=%@';", cookie.name, cookie.value)
        }
        let script:WKUserScript = WKUserScript.init(source: cookieString, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false);
        return script;
    }
    
    func setupWKWebView() -> Void {
        let config:WKWebViewConfiguration = WKWebViewConfiguration.init();
        let script:WKUserScript = injectCookie()
        let userContentController:WKUserContentController = WKUserContentController.init()
        userContentController.addUserScript(script)
        config.userContentController = userContentController
        config.processPool = self.processPool ?? WKProcessPool.init();
        self.wkwebview = WKWebView.init(frame: CGRect.init(x: 0, y: 100, width: self.view.bounds.width, height: self.view.bounds.height-100), configuration: config);
        if let realWKWebView = self.wkwebview {
            self.view.addSubview(realWKWebView);
            let url:URL? = URL.init(string: self.jumpUrl);
            if let realUrl = url {
                realWKWebView.load(URLRequest.init(url: realUrl));
            }
        }
    }

}
