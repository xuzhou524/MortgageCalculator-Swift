//
//  UIWebViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/21.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import WebKit

class UIWebViewController: UIViewController,WKNavigationDelegate,WKUIDelegate {

    var housingMarketDetailUrl : String?
    var titleStr : String?
    
    private var webView = WKWebView()
    private var progressView = UIProgressView()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        progressView.setProgress(0.3, animated: true)
        progressView.reloadInputViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "详情"
        if (titleStr != nil) {
            self.title = titleStr
        }
        
        webView.backgroundColor = XZSwiftColor.gray
        webView.navigationDelegate = self
        webView.uiDelegate = self;
        webView.load(URLRequest(url: URL.init(string: self.housingMarketDetailUrl!)!))
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.bottom.equalTo(self.view)
        }
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        progressView = UIProgressView(frame: CGRect(x: 0, y: 44-2, width: UIScreen.main.bounds.size.width, height: 2))
        progressView.trackTintColor = UIColor.white
        progressView.progressTintColor = XZSwiftColor.xzGlay50
        self.navigationController?.navigationBar.addSubview(progressView)
        
    }
    
//    func backItemPressed() {
//        if webView.canGoBack {
//            webView.goBack()
//        }else{
//            if let nav = self.navigationController {
//                nav.popViewController(animated: true)
//            }
//        }
//    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            print(webView.estimatedProgress)
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.3, animated: true)
        //self.navigationItem.title = webView.title
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        progressView.reloadInputViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
