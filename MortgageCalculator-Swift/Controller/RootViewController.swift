//
//  RootViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/7/31.
//  Copyright © 2017年 xuzhou. All rights reserved.
//

import UIKit
import SnapKit
import StoreKit

class RootViewController: UIViewController {
    
    var rootSegmentedVC : UISegmentedControl?
    var commerciaiLoansVC : CommercialLoansTableViewController?
    var accumulationLoansVC : AccumulationFundTableViewController?
    var combinationLoansVC : CombinationLoabsTableViewController?
    
    var loanCacheModel : LoanCacheManage?
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "房贷计算器"
        label.font = XZClient.XZFont3(size: 20)
        label.textColor = UIColor.init(named: "ic_theme")
        return label
    }()
    
    let rightBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "ic_More"), for: .normal)
        return btn
    }()
    
    let myLoanInfoView:MyLoanInfoView = {
        let view = MyLoanInfoView()
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.getCustomObject(forKey: "kTMCacheLoanManage") as? LoanCacheManage != nil {
            self.loanCacheModel = UserDefaults.standard.getCustomObject(forKey: "kTMCacheLoanManage") as? LoanCacheManage
            if self.loanCacheModel?.startPaymentStr?.Lenght == 8 {
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
                myLoanInfoView.bind(model: self.loanCacheModel)
                pushMessage()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.navigationController?.navigationBar.isTranslucent = false;
        rightBtn.addTarget(self,action:#selector(right),for:.touchUpInside)
        
        self.view.addSubview(myLoanInfoView)
        self.myLoanInfoView.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(145)
        })
        myLoanInfoView.bind(model: self.loanCacheModel)
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(addMyLoanInfoViewTap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        myLoanInfoView.addGestureRecognizer(tapGestureRecognizer)

        self.rootSegmentedVC = UISegmentedControl(items: ["商业贷款","公积金贷款","组合贷款"])
        self.rootSegmentedVC?.tintColor = XZSwiftColor.xzGlay50
        self.rootSegmentedVC?.setTitleTextAttributes([NSAttributedString.Key.font:XZClient.XZFont2(size: 15)], for: .normal)
        self.view.addSubview(self.rootSegmentedVC!)
        self.rootSegmentedVC?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(150)
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
            make.height.equalTo(40)
        })
        
        self.rootSegmentedVC?.selectedSegmentIndex = 0;
        self.rootSegmentedVC?.addTarget(self, action: #selector(RootViewController.segmentDidchange), for: .valueChanged)
        
        self.segmentDidchange(segmented: self.rootSegmentedVC!)
        
        SKStoreReviewController.requestReview()
    
    }
    
    @objc func segmentDidchange(segmented:UISegmentedControl){
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
            #if DEBUG
            #else
            self.view.bringSubviewToFront(bannerView)
            #endif
            
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
            #if DEBUG
            #else
            self.view.bringSubviewToFront(bannerView)
            #endif
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
            #if DEBUG
            #else
            self.view.bringSubviewToFront(bannerView)
            #endif
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension RootViewController {

    @objc func right() {
        let p = CGPoint(x: XZClient.ScreenWidth() - 32, y: (XZClient.XZiPhoneX() ? 82 : 60))
        YBPopupMenu.show(at: p, titles: ["添加","利率","更多"], icons: ["ic_AddInfo","ic_lilv","ic_MoreInfo"], menuWidth: 120) { popupMenu in
            popupMenu?.priorityDirection = .top
            popupMenu?.dismissOnSelected = true;
            popupMenu?.delegate = self;
            popupMenu?.type = .dark;
            
            popupMenu?.fontSize = 16
            popupMenu?.textColor = UIColor.white
            popupMenu?.itemHeight = 60
        }

    }
    
    @objc func addMyLoanInfoViewTap() {
        if self.loanCacheModel != nil {
            let editorVC = RemindTableViewController()
            editorVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(editorVC, animated: true)
        }else{
            self.navigationController?.pushViewController(RemindEditorViewController(), animated: true)
        }
    }
    
}

extension RootViewController:YBPopupMenuDelegate {
    
    func ybPopupMenuDidSelected(at index: Int, ybPopupMenu: YBPopupMenu!) {
        if index == 0 {
            self.navigationController?.pushViewController(RemindEditorViewController(), animated: true)
        }else if index == 1 {
            self.navigationController?.pushViewController(InterestTableViewController(), animated: true)
        }else if index == 2 {
            self.navigationController?.pushViewController(UserViewController(), animated: true)
        }
    }
    
}

extension RootViewController {
    
    func pushMessage() {
        UIApplication.shared.cancelAllLocalNotifications()
        var components:DateComponents = DateComponents()
//        components.weekday = 2;//周-
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
            }
        }
    }
    
}
