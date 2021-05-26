//
//  AppDelegate.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/7/31.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import UserNotifications
import AsyncDisplayKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var rootNavigationController: XZSwiftNavigationController?
    var remindNavigationController: XZSwiftNavigationController?
    var moreNavigationController: XZSwiftNavigationController?
    var HousingMarketController: XZSwiftNavigationController?
    
    var homeTabBarController: UITabBarController?
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        #else
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        #endif
        
        self.pushRegisterNotifcation()
        
        self.window = UIWindow()
        self.window?.frame = UIScreen.main.bounds
        self.window?.backgroundColor = UIColor.white
        
        self.rootNavigationController = XZSwiftNavigationController(rootViewController: RootViewController())
//        self.rootNavigationController?.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "tabbar_home"), selectedImage: UIImage(named: "tabbar_home_selected"))

//        self.HousingMarketController = XZSwiftNavigationController(rootViewController: (HousingMarketListViewController.init(node: ASTableNode(style: .plain))))
//        self.HousingMarketController?.tabBarItem = UITabBarItem(title: "生活", image: UIImage(named: "tabbar_housing"), selectedImage: UIImage(named: "tabbar_housing_selected"))
        
//        self.remindNavigationController = XZSwiftNavigationController(rootViewController: RemindTableViewController())
//        self.remindNavigationController?.tabBarItem = UITabBarItem(title: "提醒", image: UIImage(named: "tabbar_profile"), selectedImage: UIImage(named: "tabbar_profile_selected"))
        
        self.moreNavigationController = XZSwiftNavigationController(rootViewController: MoreViewController())
        self.moreNavigationController?.tabBarItem = UITabBarItem(title: "更多", image: UIImage(named: "icon_tabbar_onsite"), selectedImage: UIImage(named: "icon_tabbar_onsite_selected"))

        self.homeTabBarController = UITabBarController()
        self.homeTabBarController?.viewControllers = [self.rootNavigationController!, self.moreNavigationController!]
        
        // 设置字体大小
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11.0)], for: UIControl.State.normal)
        // 设置字体偏移
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: 0.0)
        // 设置图标选中时颜色
        UITabBar.appearance().tintColor = UIColor.init(named: "ic_theme")
        UITabBar.appearance().isTranslucent = false
        
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

