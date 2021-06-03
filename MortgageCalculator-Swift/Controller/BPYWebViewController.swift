//
//  BPYWebViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/21.
//  Copyright © 2017年 xuzhou. All rights reserved.
//

import UIKit
import WebKit

class BPYWebViewController: UIViewController {

    var url:String?
    var titleStr:String?
    
    init(url:String,titleStr:String) {
        self.url = url
        self.titleStr = titleStr
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let webView:WKWebView = {
        
        var jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        var wkUScript = WKUserScript.init(source: jScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)

        var wkUController = WKUserContentController()
        wkUController.addUserScript(wkUScript)
      
        var wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        
        let web = WKWebView.init(frame: CGRect(x: 0 , y: 0, width: XZClient.ScreenWidth(), height: XZClient.ScreenHeight() - 50), configuration: wkWebConfig)
        web.backgroundColor = UIColor(named: "color_theme")
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.titleStr
        self.view.backgroundColor = UIColor(named: "color_theme")
        
        self.view.addSubview(webView)
        webView.backgroundColor = UIColor(named: "color_theme")
        
        if let urlStr = self.url {
            let data = urlStr.data(using: String.Encoding.utf8)
            if let newUrl = URL(dataRepresentation: data!, relativeTo: nil) {
                 let request = URLRequest(url: newUrl)
                 webView.load(request)
            }
        }
    }
    
    @objc func back(){
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            if self.webView.canGoBack{
                self.webView.goBack()
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
