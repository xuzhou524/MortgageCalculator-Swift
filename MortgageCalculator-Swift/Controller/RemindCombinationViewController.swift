//
//  RemindCombinationViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/21.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class RemindCombinationViewController: UITableViewController {
    var rootNavigationController: XZSwiftNavigationController?
    var accumulationAmontTextFiled:UITextField?
    var accumulationRateTextFiled:UITextField?
    
    var businessAmontTextFiled:UITextField?
    var businessRateTextFiled:UITextField?
    
    var loanPeriodTextFiled:UITextField?
    var startPaymentTextFiled : UITextField?

    
    var typeSegmented : UISegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        regClass(self.tableView, cell: BaseTableViewCell.self)
        regClass(self.tableView, cell: LoansTypeTableViewCell.self)
        regClass(self.tableView, cell: BottonTableViewCell.self)
        
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(RemindCombinationViewController.backupgroupTap))
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
        return 8
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 7 {
            return 90
        }
        return 50
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 7 {
            let cell = getCell(tableView, cell: BottonTableViewCell.self, indexPath: indexPath)
            cell.calculateButton?.addTarget(self, action: #selector(RemindCombinationViewController.saveClick), for: .touchUpInside)
            cell.calculateButton?.setTitle("保存", for: .normal)
            return cell
        }
        
        if indexPath.row == 6 {
            let cell = getCell(tableView, cell: LoansTypeTableViewCell.self, indexPath: indexPath)
            self.typeSegmented = cell.typeSegmented
            return cell
        }
        
        let cell = getCell(tableView, cell: BaseTableViewCell.self, indexPath: indexPath)
        
        if indexPath.row == 0 {
            cell.titleLabel?.text = "公积金贷款金额（万元）"
            cell.topSepView?.isHidden = false
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.summeryLabel?.isHidden = true
            cell.textField?.keyboardType = .numbersAndPunctuation
            self.accumulationAmontTextFiled = cell.textField
        }else if indexPath.row == 1 {
            cell.titleLabel?.text = "公积金贷款利率（%）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.summeryLabel?.isHidden = true
            cell.textField?.text = "3.25"
            cell.textField?.keyboardType = .numbersAndPunctuation
            self.accumulationRateTextFiled = cell.textField
        }else if indexPath.row == 2 {
            cell.titleLabel?.text = "商业贷款金额（万元）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.summeryLabel?.isHidden = true
            cell.textField?.keyboardType = .numbersAndPunctuation
            self.businessAmontTextFiled = cell.textField
        }else if indexPath.row == 3 {
            cell.titleLabel?.text = "商业贷款利率（%）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.summeryLabel?.isHidden = true
            cell.textField?.text = "4.9"
            cell.textField?.keyboardType = .numbersAndPunctuation
            self.businessRateTextFiled = cell.textField
        }else if indexPath.row == 4 {
            cell.titleLabel?.text = "贷款年限（年）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.summeryLabel?.isHidden = true
            cell.textField?.keyboardType = .numbersAndPunctuation
            self.loanPeriodTextFiled = cell.textField
        }else if indexPath.row == 5 {
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
        
        if  ((self.businessAmontTextFiled?.text?.Lenght)! <= 0 || (self.businessRateTextFiled?.text?.Lenght)! <= 0 || (self.accumulationAmontTextFiled?.text?.Lenght)! <= 0 || (self.accumulationRateTextFiled?.text?.Lenght)! <= 0) {
            return
        }
        
        self.backupgroupTap()
        
        let loanModel = LoanCacheManage.init()
        loanModel.businessPrincipalStr = self.businessAmontTextFiled?.text
        loanModel.businessRateStr = self.businessRateTextFiled?.text
        
        loanModel.accumulationPrincipalStr = self.accumulationAmontTextFiled?.text
        loanModel.accumulationRateStr = self.accumulationRateTextFiled?.text
        loanModel.numberYearStr = self.loanPeriodTextFiled?.text
        
        loanModel.startPaymentStr = self.startPaymentTextFiled?.text
        
        let str = (self.startPaymentTextFiled?.text)! as NSString
        let repaymentDate = str.substring(with: NSMakeRange(str.length - 2, 2)) //还款日期
        loanModel.repaymentDateStr = repaymentDate
        
        loanModel.loanTypeStr = "3"
        loanModel.reimbursementTypeStr = String(format:"%d",(self.typeSegmented?.selectedSegmentIndex)!)
        UserDefaults.standard.saveCustomObject(customObject: loanModel, key: "kTMCacheLoanManage")
        self.rootNavigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
