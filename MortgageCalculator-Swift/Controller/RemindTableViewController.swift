//
//  RemindTableViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/2.
//  Copyright © 2017年 xuzhou. All rights reserved.
//

import UIKit
import UserNotifications
import AdKleinSDK

class RemindTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var remindDayTitleView : RemindDayTitleView?
    var loanCacheModel : LoanCacheManage?
    
    var bannerView:AdKleinSDKBannerAdView?
    
    fileprivate var _tableView: UITableView!
    fileprivate var tableView: UITableView{
        get{
            if _tableView == nil{
                
                _tableView = UITableView()
                _tableView?.backgroundColor = XZSwiftColor.convenientBackgroundColor
                _tableView?.separatorStyle = .none
                _tableView?.delegate = self
                _tableView?.dataSource = self
                
                regClass(_tableView, cell:LoanNextMouth_TitleTableViewCell.self)
                regClass(_tableView, cell:LoanDetails_DescribeTableViewCell.self)
                regClass(_tableView, cell:LoanDetails_CumulativeTableViewCell.self)
                regClass(_tableView, cell:LoanDetails_DescribesTableViewCell.self)
            }
            return _tableView
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.getCustomObject(forKey: "kTMCacheLoanManage") as? LoanCacheManage != nil {
            self.loanCacheModel = UserDefaults.standard.getCustomObject(forKey: "kTMCacheLoanManage") as? LoanCacheManage

            let dfmatter = DateFormatter()
            dfmatter.dateFormat="yyyyMMdd"
            //首次还款时间戳
            let dayStr = dfmatter.date(from:(self.loanCacheModel?.startPaymentStr)!)
            let gregorians = Calendar.init(identifier: .gregorian)
            let result = gregorians.compare(Date(), to: dayStr!, toGranularity: .month)
            if result.rawValue == 1 {  //开始还款
                let monthNumbers = gregorians.dateComponents([.year, .month, .hour], from: dayStr!, to: Date())
                self.loanCacheModel?.alsoNumberMonthStr = String(monthNumbers.month! + 12 * monthNumbers.year! + 1 )
            }else{
                self.loanCacheModel?.alsoNumberMonthStr = "0"
            }
            self.pushMessage()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的信息"
        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor;
        
        //展示广告
        showBannerView()
        
        self.remindDayTitleView = RemindDayTitleView()
        self.view.addSubview(self.remindDayTitleView!)
        self.remindDayTitleView?.snp.makeConstraints({ (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(190)
        });
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-100)
            make.top.equalTo((self.remindDayTitleView?.snp.bottom)!).offset(10)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (self.loanCacheModel != nil) {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 60
        case 1:
            if self.loanCacheModel?.loanTypeStr == "3" {
                return 130
            }
            return 80
        case 2:
            return 80
        default: break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.remindDayTitleViewData()
        switch indexPath.row {
        case 0:
            let cell = getCell(tableView, cell: LoanNextMouth_TitleTableViewCell.self, indexPath: indexPath)
            if self.loanCacheModel?.loanTypeStr == "1"{  //商业贷款
               if let str = self.loanCacheModel?.businessPrincipalStr,
                let str2 = self.loanCacheModel?.numberYearStr,
                let str3 = self.loanCacheModel?.businessRateStr,
                let i = self.loanCacheModel?.reimbursementTypeStr,
                let i2 = self.loanCacheModel?.alsoNumberMonthStr
               {
                cell.bind(loanAmountStr: str,
                          loanNumberStr: str2,
                          loanRateStr: str3,
                          loanTypeInt:NSInteger(i)!,
                          numberMonth: NSInteger(i2)!)
                }
            }else if self.loanCacheModel?.loanTypeStr == "2"{ //公积金贷款
                cell.bind(loanAmountStr: (self.loanCacheModel?.accumulationPrincipalStr)!,
                          loanNumberStr: (self.loanCacheModel?.numberYearStr!)!,
                          loanRateStr: (self.loanCacheModel?.accumulationRateStr)!,
                          loanTypeInt: NSInteger((self.loanCacheModel?.reimbursementTypeStr)!)!,
                          numberMonth: NSInteger((self.loanCacheModel?.alsoNumberMonthStr)!)!)
            }else if self.loanCacheModel?.loanTypeStr == "3" { //组合贷款
                cell.binds(accumulationAmontStr: (self.loanCacheModel?.accumulationPrincipalStr)!,
                           accumulationRateStr: (self.loanCacheModel?.accumulationRateStr!)!,
                           businessAmontStr: (self.loanCacheModel?.businessPrincipalStr!)!,
                           businessRateStr: (self.loanCacheModel?.businessRateStr!)!,
                           loanNumberStr: (self.loanCacheModel?.numberYearStr!)!,
                           loanTypeInt: NSInteger((self.loanCacheModel?.reimbursementTypeStr)!)!,
                           numberMonth: NSInteger((self.loanCacheModel?.alsoNumberMonthStr)!)!)
            }
            return cell
        case 1:
            if self.loanCacheModel?.loanTypeStr == "1"{  //商业贷款
                let cell = getCell(tableView, cell: LoanDetails_DescribeTableViewCell.self, indexPath: indexPath)
                cell.bind(loanAmountStr: (self.loanCacheModel?.businessPrincipalStr)!, loanNumberStr: (self.loanCacheModel?.numberYearStr!)!, loanRateStr: (self.loanCacheModel?.businessRateStr)!)
                return cell
            }else if self.loanCacheModel?.loanTypeStr == "2"{ //公积金贷款
                let cell = getCell(tableView, cell: LoanDetails_DescribeTableViewCell.self, indexPath: indexPath)
                cell.bind(loanAmountStr: (self.loanCacheModel?.accumulationPrincipalStr)!, loanNumberStr: (self.loanCacheModel?.numberYearStr!)!, loanRateStr: (self.loanCacheModel?.accumulationRateStr)!)
                return cell
            }else if self.loanCacheModel?.loanTypeStr == "3" { //组合贷款
                let cell = getCell(tableView, cell: LoanDetails_DescribesTableViewCell.self, indexPath: indexPath)
                cell.bind(businessAmountStr: (self.loanCacheModel?.businessPrincipalStr!)!, businessRateStr: (self.loanCacheModel?.businessRateStr!)!, accumulationAmountStr: (self.loanCacheModel?.accumulationPrincipalStr)!, accumulationRateStr: (self.loanCacheModel?.accumulationRateStr!)!, loanNumberStr: (self.loanCacheModel?.numberYearStr!)!)
                return cell
            }
        case 2:
            let cell = getCell(tableView, cell: LoanDetails_CumulativeTableViewCell.self, indexPath: indexPath)
            if self.loanCacheModel?.loanTypeStr == "1"{  //商业贷款
                cell.bind(loanAmountStr: (self.loanCacheModel?.businessPrincipalStr)!, loanNumberStr: (self.loanCacheModel?.numberYearStr!)!, loanRateStr: (self.loanCacheModel?.businessRateStr)!, loanTypeInt: NSInteger((self.loanCacheModel?.reimbursementTypeStr)!)!)
            }else if self.loanCacheModel?.loanTypeStr == "2"{ //公积金贷款
                cell.bind(loanAmountStr: (self.loanCacheModel?.accumulationPrincipalStr)!, loanNumberStr: (self.loanCacheModel?.numberYearStr!)!, loanRateStr: (self.loanCacheModel?.accumulationRateStr)!, loanTypeInt: NSInteger((self.loanCacheModel?.reimbursementTypeStr)!)!)
                return cell
            }else if self.loanCacheModel?.loanTypeStr == "3" { //组合贷款
                cell.binds(businessAmountStr: (self.loanCacheModel?.businessPrincipalStr!)!, businessRateStr: (self.loanCacheModel?.businessRateStr!)!, accumulationAmountStr: (self.loanCacheModel?.accumulationPrincipalStr)!, accumulationRateStr: (self.loanCacheModel?.accumulationRateStr!)!, loanNumberStr: (self.loanCacheModel?.numberYearStr!)!, loanTypeInt:  NSInteger((self.loanCacheModel?.reimbursementTypeStr)!)!)
            }
            return cell
        default: break
        }
        return UITableViewCell()
    }

    func remindDayTitleViewData(){
        var dayStr = String()
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        
        if (comps.month == 12) {
            dayStr = String(comps.year! + 1) + "01" + (self.loanCacheModel?.repaymentDateStr)!
        }else if (comps.month! < 9) {
            dayStr = String(comps.year!) + "0" + String(comps.month! + 1) + (self.loanCacheModel?.repaymentDateStr)!
        }else{
            dayStr = String(comps.year!) + String(comps.month! + 1) + (self.loanCacheModel?.repaymentDateStr)!
        }
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyyMMdd"
        //首次还款时间戳
        let dayStrs = dfmatter.date(from:dayStr)
        let gregorians = Calendar.init(identifier: .gregorian)
        let dayNumber = gregorians.dateComponents([.month , .day , .hour], from:Date(), to:dayStrs!)
        if dayNumber.day == 0 {
            self.remindDayTitleView?.dayLabel?.text = "明天"
            self.remindDayTitleView?.dayTitleLabel?.text = ""
        }else{
            self.remindDayTitleView?.dayLabel?.text = String(dayNumber.day!)
            self.remindDayTitleView?.dayTitleLabel?.text = "天"
        }
    }
    
    func pushMessage() {
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
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
        
        var components:DateComponents = DateComponents()
//        components.weekday = 6;//周-
        components.day = Int((self.loanCacheModel?.repaymentDateStr)!)! - 1;
        components.hour = 9;//9点
        components.minute = 30
        let content = UNMutableNotificationContent()
        content.userInfo = ["id": "1",  "title": "房贷还款提醒" ,"body" : "贷友：明天是您的还款日，请及时查询还款账号是否有money,以免影响您征信哦！"]
        content.sound = UNNotificationSound.default
        content.body = "贷友：明天是您的还款日，请及时查询还款账号是否有money,以免影响您征信哦！"
        let triggerDateComponents = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier:"YongYiFangDai", content: content, trigger: triggerDateComponents)
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil {
                //print("Time Interval Notification scheduled: \(requestIdentifier)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RemindTableViewController:AdKleinSDKBannerAdViewDelegate {
    func showBannerView() {
        self.bannerView = AdKleinSDKBannerAdView.init(placementId: CONST_BANNER_ID, viewController: self)
        let h = (XZClient.ScreenWidth() - 20) / 6.4 + 10
        self.bannerView?.frame = CGRect(x: 10, y: XZClient.ScreenHeight() - h - (XZClient.XZiPhoneX() ? 100 : 64), width: XZClient.ScreenWidth() - 20, height: h)
        self.bannerView?.animated = true
        self.bannerView?.autoSwitchInterval = 60
        self.bannerView?.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.view.addSubview(self.bannerView!)
        self.bannerView?.load()
    }
    
}
