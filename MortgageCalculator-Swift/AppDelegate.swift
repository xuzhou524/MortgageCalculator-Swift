//
//  AppDelegate.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/7/31.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var rootNavigationController: XZSwiftNavigationController?
    var remindNavigationController: XZSwiftNavigationController?
    var moreNavigationController: XZSwiftNavigationController?
    
    var homeTabBarController: UITabBarController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        self.window?.frame = UIScreen.main.bounds
        self.window?.backgroundColor = UIColor.white
        
        self.rootNavigationController = XZSwiftNavigationController(rootViewController: RootViewController())
        self.rootNavigationController?.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "tabbar_home"), selectedImage: UIImage(named: "tabbar_home_selected"))

        self.remindNavigationController = XZSwiftNavigationController(rootViewController: RemindTableViewController())
        self.remindNavigationController?.tabBarItem = UITabBarItem(title: "提醒", image: UIImage(named: "tabbar_profile"), selectedImage: UIImage(named: "tabbar_profile_selected"))
        
        self.moreNavigationController = XZSwiftNavigationController(rootViewController: MoreViewController())
        self.moreNavigationController?.tabBarItem = UITabBarItem(title: "更多", image: UIImage(named: "icon_tabbar_onsite"), selectedImage: UIImage(named: "icon_tabbar_onsite_selected"))

        self.homeTabBarController = UITabBarController()
        self.homeTabBarController?.viewControllers = [self.rootNavigationController!,self.remindNavigationController!, self.moreNavigationController!]
        
        // 设置字体大小
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 11.0)], for: UIControlState.normal)
        // 设置字体偏移
        UITabBarItem.appearance().titlePositionAdjustment = UIOffsetMake(0.0, 0.0)
        // 设置图标选中时颜色
        UITabBar.appearance().tintColor = XZSwiftColor.xzGlay50
        
        self.window?.rootViewController = self.homeTabBarController
        self.window?.makeKeyAndVisible()
    
        return true
    }
    
    func pushRegisterNotifcation() {
        if #available(iOS 10.0, *) {
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
        } else {
            let seetings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(seetings)
        }
    }

    /** 接收本地通知  运行*/
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        let aler = UIAlertView.init(title: notification.userInfo?[AnyHashable("title")] as? String, message: notification.userInfo?[AnyHashable("body")] as? String, delegate: self, cancelButtonTitle: "我知道了")
        aler.show()
    }

    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.pushRegisterNotifcation()
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("=========%@",deviceToken)
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
         
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //UIApplication.shared.applicationIconBadgeNumber = 0
        //let aler = UIAlertView.init(title: "本地通知", message: "消息内容", delegate:self, cancelButtonTitle: "取消")
        //aler.show()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

