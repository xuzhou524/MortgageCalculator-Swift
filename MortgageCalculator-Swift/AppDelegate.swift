//
//  AppDelegate.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/7/31.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

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

        self.remindNavigationController = XZSwiftNavigationController(rootViewController: remindTableViewController())
        self.remindNavigationController?.tabBarItem = UITabBarItem(title: "提醒", image: UIImage(named: "tabbar_profile"), selectedImage: UIImage(named: "tabbar_profile_selected"))
        
        self.moreNavigationController = XZSwiftNavigationController(rootViewController: MoreViewController())
        self.moreNavigationController?.tabBarItem = UITabBarItem(title: "更多", image: UIImage(named: "icon_tabbar_onsite"), selectedImage: UIImage(named: "icon_tabbar_onsite_selected"))

        self.homeTabBarController = UITabBarController()
        self.homeTabBarController?.viewControllers = [self.rootNavigationController!, self.remindNavigationController!, self.moreNavigationController!]
        
        // 设置字体颜色
        //UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: UIControlState.normal)
        //UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: UIControlState.selected)
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

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

