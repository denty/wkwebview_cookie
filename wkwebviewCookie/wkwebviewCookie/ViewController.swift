//
//  ViewController.swift
//  wkwebviewCookie
//
//  Created by shiqi sun on 2019/1/10.
//  Copyright © 2019 denty. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var get_cookie_button: UIButton!
    @IBOutlet weak var set_server_cookie_button: UIButton!
    @IBOutlet weak var set_js_cookie_button: UIButton!
    let processPool:WKProcessPool = WKProcessPool.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        get_cookie_button.addTarget(self, action: #selector(presentToGetCookiePage), for: .touchUpInside)
        
        set_js_cookie_button.addTarget(self, action: #selector(presentToSetJSCookiePage), for: .touchUpInside)
        
        set_server_cookie_button.addTarget(self, action: #selector(presentToSetServerCookiePage), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func presentToGetCookiePage() -> Void {
        let vc:CookieWKWebViewController = CookieWKWebViewController()
        vc.jumpUrl = "http://127.0.0.1:2019/getcookie.html"
        vc.processPool = processPool
        self.present(vc, animated: true, completion: nil);
    }
    
    @objc func presentToSetJSCookiePage() -> Void {
        let vc:CookieWKWebViewController = CookieWKWebViewController()
         vc.jumpUrl = "http://127.0.0.1:2019/setjscookie.html"
        vc.processPool = processPool
        self.present(vc, animated: true, completion: nil);
    }
    
    @objc func presentToSetServerCookiePage() -> Void {
        let vc:CookieWKWebViewController = CookieWKWebViewController()
        vc.jumpUrl = "http://127.0.0.1:2019/setservercookie.html"
        vc.processPool = processPool
        self.present(vc, animated: true, completion: nil);
    }
}

