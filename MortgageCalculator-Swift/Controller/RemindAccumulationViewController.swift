//
//  RemindAccumulationViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/21.
//  Copyright © 2017年 xuzhou. All rights reserved.
//

import UIKit

class RemindAccumulationViewController: UITableViewController {
    var rootNavigationController: XZSwiftNavigationController?
    var loanAmontTextFiled:UITextField?
    var loanPeriodTextFiled:UITextField?
    var loanRateTextFiled:UITextField?
    var startPaymentTextFiled : UITextField?
    
    var typeSegmented : UISegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        regClass(self.tableView, cell: BaseTableViewCell.self)
        regClass(self.tableView, cell: LoansTypeTableViewCell.self)
        regClass(self.tableView, cell: BottonTableViewCell.self)
        
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(RemindAccumulationViewController.backupgroupTap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.cancelsTouchesInView = false
    }
    
    @objc func backupgroupTap(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 5 {
            return 90
        }
        return 50
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 5 {
            let cell = getCell(tableView, cell: BottonTableViewCell.self, indexPath: indexPath)
            cell.calculateButton?.addTarget(self, action: #selector(RemindAccumulationViewController.saveClick), for: .touchUpInside)
            cell.calculateButton?.setTitle("保存", for: .normal)
            return cell
        }
        
        if indexPath.row == 4 {
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
            cell.textField?.keyboardType = .numbersAndPunctuation
            self.loanAmontTextFiled = cell.textField
        }else if indexPath.row == 1 {
            cell.titleLabel?.text = "贷款年限（年）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.summeryLabel?.isHidden = true
            cell.textField?.keyboardType = .numberPad
            self.loanPeriodTextFiled = cell.textField
        }else if indexPath.row == 2 {
            cell.titleLabel?.text = "贷款利率/LPR（%）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.summeryLabel?.isHidden = true
            cell.textField?.text = "3.25"
            cell.textField?.keyboardType = .numbersAndPunctuation
            self.loanRateTextFiled = cell.textField
        }else if indexPath.row == 3 {
            cell.titleLabel?.text = "首次还款日"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.summeryLabel?.isHidden = true
            cell.textField?.placeholder = "eg：20170524"
            cell.textField?.keyboardType = .numberPad
            self.startPaymentTextFiled = cell.textField
        }
        return cell
    }
    
    @objc func saveClick(){
        
        if  ((self.loanAmontTextFiled?.text?.Lenght)! <= 0 || (self.loanPeriodTextFiled?.text?.Lenght)! <= 0 || (self.loanRateTextFiled?.text?.Lenght)! <= 0) {
            return
        }
        
        self.backupgroupTap()
    
        let loanModel = LoanCacheManage.init()
        loanModel.accumulationPrincipalStr = self.loanAmontTextFiled?.text
        loanModel.numberYearStr = self.loanPeriodTextFiled?.text
        loanModel.accumulationRateStr = self.loanRateTextFiled?.text
        loanModel.startPaymentStr = self.startPaymentTextFiled?.text
        
        let str = (self.startPaymentTextFiled?.text)! as NSString
        let repaymentDate = str.substring(with: NSMakeRange(str.length - 2, 2)) //还款日期
        loanModel.repaymentDateStr = repaymentDate
        
        loanModel.loanTypeStr = "2"
        loanModel.reimbursementTypeStr = String(format:"%d",(self.typeSegmented?.selectedSegmentIndex)!)
        
        UserDefaults.standard.saveCustomObject(customObject: loanModel, key: "kTMCacheLoanManage")
        self.rootNavigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
