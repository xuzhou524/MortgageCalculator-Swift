//
//  XZSwiftNavigationController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/2.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit


class XZSwiftNavigationController: UINavigationController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationBar.setBackgroundImage(createImageWithColor(XZSwiftColor.convenientBackgroundColor), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.tintColor = XZSwiftColor.xzGlay50
        self.navigationBar.titleTextAttributes = [
            .font: XZClient.XZFont(size: 18),
            .foregroundColor: XZSwiftColor.xzGlay50]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let bar = UINavigationBar.appearance(whenContainedInInstancesOf: [XZSwiftNavigationController.self])
        bar.backIndicatorImage = UIImage(named: "ic_back")
        bar.backIndicatorTransitionMaskImage = UIImage(named: "ic_back")
        bar.tintColor = XZSwiftColor.xzGlay50
        let barButton = UIBarButtonItem.appearance(whenContainedInInstancesOf: [XZSwiftNavigationController.self])
        barButton.setTitleTextAttributes([NSAttributedString.Key.font: XZClient.XZFont(size: 0)], for: .normal)
        barButton.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for: .default)
 
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }

    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        if viewControllers.count > 1 {
            let vc = viewControllers.last
            vc?.hidesBottomBarWhenPushed = true
        }
        super.setViewControllers(viewControllers, animated: animated)
    }

}
