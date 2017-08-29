//
//  CombinationLoabsTableViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/1.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class CombinationLoabsTableViewController: UITableViewController {
    
    var rootNavigationController: XZSwiftNavigationController?

    var accumulationAmontTextFiled:UITextField?
    var accumulationRateTextFiled:UITextField?
    
    var businessAmontTextFiled:UITextField?
    var businessRateTextFiled:UITextField?
    
    var loanPeriodTextFiled:UITextField?
    
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
            cell.calculateButton?.addTarget(self, action: #selector(CombinationLoabsTableViewController.calculateClick), for: .touchUpInside)
            return cell
        }
        
        if indexPath.row == 5 {
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
            cell.textField?.keyboardType = .numbersAndPunctuation
            self.accumulationAmontTextFiled = cell.textField
        }else if indexPath.row == 1 {
            cell.titleLabel?.text = "公积金贷款利率（%）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.textField?.text = "3.25"
            cell.textField?.keyboardType = .numbersAndPunctuation
            self.accumulationRateTextFiled = cell.textField
        }else if indexPath.row == 2 {
            cell.titleLabel?.text = "商业贷款金额（万元）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.textField?.keyboardType = .numbersAndPunctuation
            self.businessAmontTextFiled = cell.textField
        }else if indexPath.row == 3 {
            cell.titleLabel?.text = "商业贷款利率（%）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.textField?.text = "4.9"
            cell.textField?.keyboardType = .numbersAndPunctuation
            self.businessRateTextFiled = cell.textField
        }else if indexPath.row == 4 {
            cell.titleLabel?.text = "贷款年限（年）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.textField?.keyboardType = .numberPad
            self.loanPeriodTextFiled = cell.textField
        }
        
        return cell
    }
    
    func calculateClick(){
        
        self.backupgroupTap()
        let accumulationAmontStr = self.accumulationAmontTextFiled?.text
        let accumulationRateStr = self.accumulationRateTextFiled?.text
        
        let businessAmontStr = self.businessAmontTextFiled?.text
        let businessRateStr = self.businessRateTextFiled?.text
        
        let loanPeriodStr = self.loanPeriodTextFiled?.text
        
        if  ((businessAmontStr?.Lenght)! > 0 && (accumulationAmontStr?.Lenght)! > 0 && (loanPeriodStr?.Lenght)! > 0) {
            let loanDetailsVC = CombinationDetailsTableViewController()
            
            loanDetailsVC.accumulationAmontStr = accumulationAmontStr
            loanDetailsVC.accumulationRateStr = accumulationRateStr
            
            loanDetailsVC.businessAmontStr = businessAmontStr
            loanDetailsVC.businessRateStr = businessRateStr
            
            loanDetailsVC.loanNumberStr = loanPeriodStr
            
            loanDetailsVC.loanTypeInt = self.typeSegmented?.selectedSegmentIndex
            self.rootNavigationController?.pushViewController(loanDetailsVC, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
