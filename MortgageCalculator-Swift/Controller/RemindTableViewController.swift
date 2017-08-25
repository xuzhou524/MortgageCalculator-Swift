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
    fileprivate var _tableView: UITableView!
    fileprivate var tableView: UITableView{
        get{
            if _tableView == nil{
                
                _tableView = UITableView()
                _tableView?.backgroundColor = XZSwiftColor.convenientBackgroundColor
                _tableView?.separatorStyle = .none
                _tableView?.delegate = self
                _tableView?.dataSource = self
                
                regClass(_tableView, cell:LoanDetails_TitleTableViewCell.self)
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
            let loanModels = TMCache.shared().object(forKey: kTMCacheLoanManage) as! LoanCacheManage
            print("=======%@",loanModels.businessPrincipalStr!)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 60
        case 1:
            return 130
            //return 80
        case 2:
            return 80
        default: break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = getCell(tableView, cell: LoanDetails_TitleTableViewCell.self, indexPath: indexPath)
            //cell.bind(loanAmountStr: self.loanAmountStr!, loanNumberStr: self.loanNumberStr!, loanRateStr: self.loanRateStr!, loanTypeInt: self.loanTypeInt!)
            return cell
        case 1:
            let cell = getCell(tableView, cell: LoanDetails_DescribesTableViewCell.self, indexPath: indexPath)
            //cell.bind(businessAmountStr: self.businessAmontStr!, businessRateStr: self.businessRateStr!, accumulationAmountStr: self.accumulationAmontStr!, accumulationRateStr: self.accumulationRateStr!, loanNumberStr: self.loanNumberStr!)

            //let cell = getCell(tableView, cell: LoanDetails_DescribeTableViewCell.self, indexPath: indexPath)
            //cell.bind(loanAmountStr: self.loanAmountStr!, loanNumberStr: self.loanNumberStr!, loanRateStr: self.loanRateStr!)
            return cell
        case 2:
            let cell = getCell(tableView, cell: LoanDetails_CumulativeTableViewCell.self, indexPath: indexPath)
            //cell.bind(loanAmountStr: self.loanAmountStr!, loanNumberStr: self.loanNumberStr!, loanRateStr: self.loanRateStr!, loanTypeInt: self.loanTypeInt!)
            return cell
        default: break
        }
        return UITableViewCell()
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
