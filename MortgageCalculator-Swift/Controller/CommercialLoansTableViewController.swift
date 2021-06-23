//
//  CommercialLoansTableViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/1.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class CommercialLoansTableViewController: UITableViewController,CalculateDelegate {
    
    var rootNavigationController: XZSwiftNavigationController?
    
    var loanAmontTextFiled:UITextField?
    var loanPeriodTextFiled:UITextField?
    var loanRateTextFiled:UITextField?
    
    var rateTypeSegmented : UISegmentedControl?
    var typeSegmented : UISegmentedControl?
    
    var calculateView : CalculateView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        regClass(self.tableView, cell: BaseTableViewCell.self)
        regClass(self.tableView, cell: LoansTypeTableViewCell.self)
        regClass(self.tableView, cell: BottonTableViewCell.self)
        
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(CommercialLoansTableViewController.backupgroupTap))
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
        
        if indexPath.row == 2 {
            let cell = getCell(tableView, cell: LoansTypeTableViewCell.self, indexPath: indexPath)
            self.rateTypeSegmented = cell.typeSegmented
            cell.titleLabel?.text = "利率方式";
            self.rateTypeSegmented?.setTitle("LPR", forSegmentAt: 0)
            self.rateTypeSegmented?.setTitle("基准利率", forSegmentAt: 1)
            self.rateTypeSegmented?.addTarget(self, action: #selector(segmentedControlChanged), for: UIControl.Event.valueChanged)
            return cell
        }else if indexPath.row == 4 {
            let cell = getCell(tableView, cell: LoansTypeTableViewCell.self, indexPath: indexPath)
            self.typeSegmented = cell.typeSegmented
            return cell
        }else if indexPath.row == 5 {
            let cell = getCell(tableView, cell: BottonTableViewCell.self, indexPath: indexPath)
            cell.calculateButton?.addTarget(self, action: #selector(CommercialLoansTableViewController.calculateClick), for: .touchUpInside)
            return cell
        }
        
        let cell = getCell(tableView, cell: BaseTableViewCell.self, indexPath: indexPath)
        
        if indexPath.row == 0 {
            cell.titleLabel?.text = "贷款金额（万元）"
            cell.topSepView?.isHidden = false
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.tapImageView.isHidden = false
            let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapView))
            tapGestureRecognizer.numberOfTapsRequired = 1
            cell.tapImageView.addGestureRecognizer(tapGestureRecognizer)
            cell.textField?.keyboardType = .numbersAndPunctuation
            self.loanAmontTextFiled = cell.textField
        }else if indexPath.row == 1 {
            cell.titleLabel?.text = "贷款年限（年）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.tapImageView.isHidden = true
            cell.textField?.keyboardType = .numberPad
            self.loanPeriodTextFiled = cell.textField
        }else if indexPath.row == 3 {
            if self.rateTypeSegmented?.selectedSegmentIndex == 1 {
                cell.titleLabel?.text = "贷款利率（%）"
                cell.textField?.text = "4.9"
            }else{
                cell.titleLabel?.text = "LPR - 基点（%）"
                cell.textField?.text = "4.75"
            }
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
            cell.tapImageView.isHidden = true
            cell.textField?.keyboardType = .numbersAndPunctuation
            self.loanRateTextFiled = cell.textField
        }
        return cell
    }
    
    @objc func calculateClick(){
        
        self.backupgroupTap()
        
        let loanAmontStr = self.loanAmontTextFiled?.text
        let loanPeriodStr = self.loanPeriodTextFiled?.text
        let loanRateStr = self.loanRateTextFiled?.text
        
        if  ((loanAmontStr?.Lenght)! > 0 && (loanPeriodStr?.Lenght)! > 0 && (loanRateStr?.Lenght)! > 0) {
            let loanDetailsVC = LoanDetailsTableViewController()
            loanDetailsVC.loanAmountStr = loanAmontStr
            loanDetailsVC.loanNumberStr = loanPeriodStr
            loanDetailsVC.loanRateStr = loanRateStr
            loanDetailsVC.loanTypeInt = self.typeSegmented?.selectedSegmentIndex
            loanDetailsVC.hidesBottomBarWhenPushed = true
            self.rootNavigationController?.pushViewController(loanDetailsVC, animated: true)
        }
    }
    
    @objc func segmentedControlChanged(){
        self.tableView.reloadRows(at: [IndexPath(row:3, section: 0)], with: .none)
    }
    
    @objc func tapView(){
        calculateView = CalculateView()
        calculateView?.delegate = self
        calculateView?.show()
    }
    
    func clickTheButton(view: CalculateView, loanAmount: CGFloat) {
        view.hide()
        self.loanAmontTextFiled?.text = "\(loanAmount)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
