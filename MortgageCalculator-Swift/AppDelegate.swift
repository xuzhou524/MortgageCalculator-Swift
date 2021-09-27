//
//  AppDelegate.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/7/31.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import UserNotifications
import AppTrackingTransparency
import AdKleinSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    var placeholderView: UIView?
    var splashAd:AdKleinSDKSplashAd?
    
    var logoView: UIView?
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.pushRegisterNotifcation()
        
        self.window = UIWindow()
        self.window?.frame = UIScreen.main.bounds
        self.window?.backgroundColor = UIColor.white
        
        self.window?.rootViewController = XZSwiftNavigationController(rootViewController: RootViewController())
        self.window?.makeKeyAndVisible()
        
        self.createPlaceholder()
        self.initSDK()
        
        return true
    }
    
    func pushRegisterNotifcation() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in
            if granted {
                center.getNotificationSettings(completionHandler: { (settings) in
                    print(settings)
                })
            } else {
                print("失败")
            }
        }
    }
    
    /** 接收本地通知  运行*/
//    - (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification API_DEPRECATED("Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]"
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//
//    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        let aler = UIAlertView.init(title: notification.userInfo?[AnyHashable("title")] as? String, message: notification.userInfo?[AnyHashable("body")] as? String, delegate: self, cancelButtonTitle: "我知道了")
        aler.show()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("=========%@",deviceToken)
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
}

extension AppDelegate:AdKleinSDKSplashAdDelegate {
    func createPlaceholder() {
        let lsname = Bundle.main.object(forInfoDictionaryKey: "UILaunchStoryboardName") ?? ""

        let vc = UIStoryboard.init(name: lsname as! String, bundle: nil).instantiateInitialViewController()
        vc?.view.frame = self.window?.bounds ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        self.window?.addSubview((vc?.view)!)
        self.placeholderView = vc?.view
    }
    
    func initSDK() {
        let userDefault = UserDefaults.standard
        
        if let temp = userDefault.object(forKey: "inited"),temp as! String == "YES" {
            self.initAdKleinSDK()
        }else{
            self.showPrivacyAlert()
        }
    }
    
    func initAdKleinSDK() {
//        AdKleinSDKConfig.debugMode()
        AdKleinSDKConfig.initMediaId(CONST_MEDIA_ID)
        self.loadSplashAd()
    }
    
    func loadSplashAd() {
        self.splashAd = AdKleinSDKSplashAd.init(placementId: CONST_SPLASH_ID, window: self.window!)
        self.splashAd?.delegate = self
        
        logoView = UIView.init(frame: CGRect(x: 0, y: 0, width: XZClient.ScreenWidth(), height: XZClient.ScreenHeight() * 0.16))
        logoView?.backgroundColor = UIColor.white
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Icon-60")
        logoView?.addSubview(imageView)
        imageView.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalToSuperview()
            make.right.equalTo(logoView!.snp_centerX).offset(-40)
            make.width.height.equalTo(60)
        }
        
        let label = UILabel()
        label.text = "房贷计算器";
        label.font = XZClient.XZFont3(size: 25)
        logoView?.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoView!.snp_centerX).offset(-20)
        })
        
        self.splashAd?.bottomView = logoView
        
        self.splashAd?.load()
    }
    
    func showPrivacyAlert() {
        let alert = PrivacyAlert()
        alert.show { result in
            if result {
                let userDefault = UserDefaults.standard
                userDefault.setValue("YES", forKey: "inited")
                userDefault.synchronize()
                if #available(iOS 14, *) {
                    ATTrackingManager.requestTrackingAuthorization { status in
                        DispatchQueue.main.async {
                            self.initAdKleinSDK()
                        }
                    }
                }
            }else{
                UIView.animate(withDuration: 0.5) {
                    self.window?.alpha = 0
                    self.window?.frame = CGRect(x: 0, y: (self.window?.bounds.size.height ?? 0) / 2, width: (self.window?.bounds.size.width ?? 0), height: 0.5)
                } completion: { finished in
                    exit(0)
                }
            }
        }
        
    }
    
    func removePlaceholder() {
        if self.placeholderView != nil {
            self.placeholderView?.removeFromSuperview()
        }
    }
    
    func ak_splashAdDidSkip(_ splashAd: AdKleinSDKSplashAd) {
        
    }
    
    func ak_splashAdTimeOver(_ splashAd: AdKleinSDKSplashAd) {
        
    }
    
    func ak_splashAdDidFail(_ splashAd: AdKleinSDKSplashAd, withError error: Error) {
        self.splashAd = nil
        self.removePlaceholder()
    }
    
    func ak_splashAdDidLoad(_ splashAd: AdKleinSDKSplashAd) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(Date(), forKey: "lastSplashTime")
        userDefault.synchronize()
    }
    
    func ak_splashAdDidShow(_ splashAd: AdKleinSDKSplashAd) {
        self.removePlaceholder()
    }
    
    func ak_splashAdDidClick(_ splashAd: AdKleinSDKSplashAd) {
        
    }
    
    func ak_splashAdDidClose(_ splashAd: AdKleinSDKSplashAd) {
        self.splashAd = nil
    }
    
}
