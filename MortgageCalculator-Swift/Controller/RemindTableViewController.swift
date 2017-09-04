//
//  RemindTableViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/2.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import TMCache

class RemindTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var remindDayTitleView : RemindDayTitleView?
    var loanCacheModel : LoanCacheManage?
    
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
        if (TMCache.shared().object(forKey: kTMCacheLoanManage) != nil) {
            self.loanCacheModel = TMCache.shared().object(forKey: kTMCacheLoanManage) as? LoanCacheManage
            
            let dfmatter = DateFormatter()
            dfmatter.dateFormat="yyyyMMdd"
            //首次还款时间戳
            let dayStr = dfmatter.date(from:(self.loanCacheModel?.startPaymentStr)!)
            let gregorians = Calendar.init(identifier: .gregorian)
            let result = gregorians.compare(Date(), to: dayStr!, toGranularity: .month)
            if result.rawValue == 1 {  //开始还款
                let monthNumber = gregorians.dateComponents([.year, .month, .hour], from:dayStr!, to: Date())
                self.loanCacheModel?.alsoNumberMonthStr = String(monthNumber.month! + 1)
            }else{
                self.loanCacheModel?.alsoNumberMonthStr = "0"
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "提醒"
        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor;
        
        let rightButton = UIButton.init(frame:CGRect(x:0, y:0, width:28, height:28))
        rightButton.setImage(UIImage(named: "selectbianji"), for: .normal)
        rightButton.setImage(UIImage(named: "bianji"), for: .highlighted)
        rightButton.addTarget(self,action:#selector(RemindTableViewController.rightTapPed),for:.touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        if (TMCache.shared().object(forKey: kTMCacheLoanManage) != nil) {
            self.remindDayTitleView = RemindDayTitleView()
            self.view.addSubview(self.remindDayTitleView!)
            self.remindDayTitleView?.snp.makeConstraints({ (make) -> Void in
                make.top.left.top.right.equalTo(self.view)
                make.height.equalTo(260)
            });
            
            self.view.addSubview(self.tableView)
            self.tableView.snp.makeConstraints { (make) -> Void in
                make.left.right.bottom.equalTo(self.view)
                make.top.equalTo((self.remindDayTitleView?.snp.bottom)!).offset(10)
            }
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
                cell.bind(loanAmountStr: (self.loanCacheModel?.accumulationPrincipalStr)!, loanNumberStr: (self.loanCacheModel?.numberYearStr!)!, loanRateStr: (self.loanCacheModel?.accumulationRateStr)!, loanTypeInt: NSInteger((self.loanCacheModel?.reimbursementTypeStr)!)!, numberMonth: NSInteger((self.loanCacheModel?.alsoNumberMonthStr)!)!)
            }else if self.loanCacheModel?.loanTypeStr == "3" { //组合贷款
                cell.binds(accumulationAmontStr: (self.loanCacheModel?.accumulationPrincipalStr)!, accumulationRateStr: (self.loanCacheModel?.accumulationRateStr!)!, businessAmontStr: (self.loanCacheModel?.businessPrincipalStr!)!, businessRateStr: (self.loanCacheModel?.businessRateStr!)!, loanNumberStr: (self.loanCacheModel?.numberYearStr!)!, loanTypeInt: NSInteger((self.loanCacheModel?.reimbursementTypeStr)!)!, numberMonth: NSInteger((self.loanCacheModel?.alsoNumberMonthStr)!)!)
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
        }else{
            self.remindDayTitleView?.dayLabel?.text = String(dayNumber.day!)
        }
        
    }

    func rightTapPed(){
        let editorVC = RemindEditorViewController()
        self.navigationController?.pushViewController(editorVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
