//
//  AppDelegate.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/7/31.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import UserNotifications
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        #else
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        #endif
        
        self.pushRegisterNotifcation()
        
        self.window = UIWindow()
        self.window?.frame = UIScreen.main.bounds
        self.window?.backgroundColor = UIColor.white

        self.window?.rootViewController = XZSwiftNavigationController(rootViewController: RootViewController())
        self.window?.makeKeyAndVisible()

        return true
    }

    func pushRegisterNotifcation() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self as? UNUserNotificationCenterDelegate
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

