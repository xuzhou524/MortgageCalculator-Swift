//
//  RootViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/7/31.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import SnapKit
import UserNotifications

class RootViewController: UIViewController {
    
    var rootSegmentedVC : UISegmentedControl?
    var commerciaiLoansVC : CommercialLoansTableViewController?
    var accumulationLoansVC : AccumulationFundTableViewController?
    var combinationLoansVC : CombinationLoabsTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Thread.sleep(forTimeInterval: 1.0)
        self.pushMessage()
        
        self.navigationItem.title = "房贷计算器"
        self.view.backgroundColor = UIColor.white;
        self.navigationController?.navigationBar.isTranslucent = false;

        self.rootSegmentedVC = UISegmentedControl(items: ["商业贷款","公积金贷款","组合贷款"])
        self.rootSegmentedVC?.tintColor = XZSwiftColor.xzGlay50
        self.rootSegmentedVC?.setTitleTextAttributes([NSFontAttributeName:XZClient.XZFont2(size: 15)], for: .normal)
        self.view.addSubview(self.rootSegmentedVC!)
        self.rootSegmentedVC?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(15)
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
            make.height.equalTo(35)
        })
        
        self.rootSegmentedVC?.selectedSegmentIndex = 0;
        self.rootSegmentedVC?.addTarget(self, action: #selector(RootViewController.segmentDidchange), for: .valueChanged)
        
        self.segmentDidchange(segmented: self.rootSegmentedVC!)
    }
    
    func segmentDidchange(segmented:UISegmentedControl){
        if segmented.selectedSegmentIndex == 0 {
            if ((self.commerciaiLoansVC) == nil) {
                self.commerciaiLoansVC = CommercialLoansTableViewController()
                self.commerciaiLoansVC?.rootNavigationController = self.navigationController as? XZSwiftNavigationController
                self.view.addSubview((self.commerciaiLoansVC?.view)!)
                self.commerciaiLoansVC?.view.snp.makeConstraints({ (make) in
                    make.left.right.bottom.equalTo(self.view)
                    make.top.equalTo((self.rootSegmentedVC?.snp.bottom)!).offset(15)
                })
            }
            self.view.addSubview((self.commerciaiLoansVC?.view)!)
        }else if  segmented.selectedSegmentIndex == 1 {
            if ((self.accumulationLoansVC) == nil) {
                self.accumulationLoansVC = AccumulationFundTableViewController()
                self.accumulationLoansVC?.rootNavigationController = self.navigationController as? XZSwiftNavigationController
                self.view.addSubview((self.accumulationLoansVC?.view)!)
                self.accumulationLoansVC?.view.snp.makeConstraints({ (make) in
                    make.left.right.bottom.equalTo(self.view)
                    make.top.equalTo((self.rootSegmentedVC?.snp.bottom)!).offset(15)
                })
            }
            self.view.addSubview((self.accumulationLoansVC?.view)!)
        }else{
            if ((self.combinationLoansVC) == nil) {
                self.combinationLoansVC = CombinationLoabsTableViewController()
                self.combinationLoansVC?.rootNavigationController = self.navigationController as? XZSwiftNavigationController
                self.view.addSubview((self.combinationLoansVC?.view)!)
                self.combinationLoansVC?.view.snp.makeConstraints({ (make) in
                    make.left.right.bottom.equalTo(self.view)
                    make.top.equalTo((self.rootSegmentedVC?.snp.bottom)!).offset(15)
                })
            }
            self.view.addSubview((self.combinationLoansVC?.view)!)
        }
    }
    
    func pushMessage() {
//        // 初始化一个通知
//        let localNoti = UILocalNotification()
//
//        // 通知的触发时间，例如即刻起15分钟后
//        let fireDate = NSDate().addingTimeInterval(1000)
//        localNoti.fireDate = fireDate as Date
//        // 设置时区
//        localNoti.timeZone = NSTimeZone.default
//        // 通知上显示的主题内容
//        localNoti.alertBody = "通知上显示的提示内容"
//        // 收到通知时播放的声音，默认消息声音
//        localNoti.soundName = UILocalNotificationDefaultSoundName
//        //待机界面的滑动动作提示
//        localNoti.alertAction = "打开应用"
//        // 应用程序图标右上角显示的消息数
//        localNoti.applicationIconBadgeNumber = 0
//        // 通知上绑定的其他信息，为键值对
//        localNoti.userInfo = ["id": "1",  "name": "xxxx"]
//
//        // 添加通知到系统队列中，系统会在指定的时间触发
//        UIApplication.shared.scheduleLocalNotification(localNoti)
        
        //每周三，13点触发
        var components:DateComponents = DateComponents()
        components.weekday = 2;//周-
        //components.day = 15;
        components.hour = 16;//13点
        components.minute = 33
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.userInfo = ["id": "1",  "title": "房贷还款提醒" ,"body" : "贷友：一月一度的还款日到了，请及时查询还款账号下是否有money,以免影响你信誉！"]
            content.sound = UNNotificationSound.default()

            let triggerDateComponents = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(identifier:"YongYiFangDai", content: content, trigger: triggerDateComponents)
            UNUserNotificationCenter.current().add(request) { error in
                if error == nil {
                    //print("Time Interval Notification scheduled: \(requestIdentifier)")
                }
            }
        } else {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
