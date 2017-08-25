//
//  RemindCommercialViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/21.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import TMCache

class RemindCommercialViewController: UITableViewController {

    var rootNavigationController: XZSwiftNavigationController?
    var loanAmontTextFiled : UITextField?
    var loanPeriodTextFiled : UITextField?
    var loanRateTextFiled : UITextField?
    var repaymentDateTextFiled : UITextField?
    var alsoNumberMonthTextFiled : UITextField?
    
    var typeSegmented : UISegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        
        regClass(self.tableView, cell: BaseTableViewCell.self)
        regClass(self.tableView, cell: LoansTypeTableViewCell.self)
        regClass(self.tableView, cell: BottonTableViewCell.self)
        
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(CommercialLoansTableViewController.backupgroupTap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.cancelsTouchesInView = false
    }
    
    func backupgroupTap(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 6 {
            return 90
        }
        return 50
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 6 {
            let cell = getCell(tableView, cell: BottonTableViewCell.self, indexPath: indexPath)
            cell.calculateButton?.addTarget(self, action: #selector(RemindCommercialViewController.saveClick), for: .touchUpInside)
            cell.calculateButton?.setTitle("保存", for: .normal)
            return cell
        }
        
        if indexPath.row == 5 {
            let cell = getCell(tableView, cell: LoansTypeTableViewCell.self, indexPath: indexPath)
            self.typeSegmented = cell.typeSegmented
            return cell
        }
        
        let cell = getCell(tableView, cell: BaseTableViewCell.self, indexPath: indexPath)
        
        if indexPath.row == 0 {
            cell.titleLabel?.text = "贷款金额（万元）"
            cell.topSepView?.isHidden = false
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.summeryLabel?.isHidden = true
            self.loanAmontTextFiled = cell.textField
        }else if indexPath.row == 1 {
            cell.titleLabel?.text = "贷款年限（年）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.summeryLabel?.isHidden = true
            self.loanPeriodTextFiled = cell.textField
        }else if indexPath.row == 2 {
            cell.titleLabel?.text = "贷款利率（%）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.summeryLabel?.isHidden = true
            cell.textField?.text = "4.9"
            self.loanRateTextFiled = cell.textField
        }else if indexPath.row == 3 {
            cell.titleLabel?.text = "还款日期"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.summeryLabel?.isHidden = false
            cell.textField?.text = "15"
            self.repaymentDateTextFiled = cell.textField
        }else if indexPath.row == 4 {
            cell.titleLabel?.text = "已还期数"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.summeryLabel?.isHidden = true
            cell.textField?.text = "0"
            self.alsoNumberMonthTextFiled = cell.textField
        }
        return cell
    }
    
    func saveClick(){
        
        if  ((self.loanAmontTextFiled?.text?.Lenght)! <= 0 || (self.loanPeriodTextFiled?.text?.Lenght)! <= 0) {
            return
        }
    
        self.backupgroupTap()
    
        let loanModel = LoanCacheManage.init()
        loanModel.businessPrincipalStr = self.loanAmontTextFiled?.text
        loanModel.numberYearStr = self.loanPeriodTextFiled?.text
        loanModel.businessRateStr = self.loanRateTextFiled?.text
        loanModel.repaymentDateStr = self.repaymentDateTextFiled?.text
        loanModel.alsoNumberMonthStr = self.alsoNumberMonthTextFiled?.text
        
        loanModel.loanTypeStr = "1"
        loanModel.reimbursementTypeStr = String(format:"%d",(self.typeSegmented?.selectedSegmentIndex)!)
        
        TMCache.shared().setObject(loanModel, forKey: kTMCacheLoanManage)
        self.rootNavigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
