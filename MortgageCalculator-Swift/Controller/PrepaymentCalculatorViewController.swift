//
//  PrepaymentCalculatorViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2026/5/24.
//  Copyright © 2026年 com.longdai. All rights reserved.
//

import UIKit

class PrepaymentCalculatorViewController: UITableViewController {
    
    var rootNavigationController: XZSwiftNavigationController?
    
    // 原始贷款信息
    var loanAmountTextField: UITextField?  // 贷款金额（万元）
    var loanPeriodTextField: UITextField?  // 贷款年限（年）
    var loanRateTextField: UITextField?    // 贷款利率（%）
    
    // 提前还款信息
    var paidMonthsTextField: UITextField?  // 已还期数（月）
    var prepaymentAmountTextField: UITextField?  // 提前还款金额（万元）
    var remainingMonthsTextField: UITextField?  // 剩余期数（系统计算）
    
    // 还款方式选择
    var typeSegmented: UISegmentedControl?  // 0:等额本息 1:等额本金
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "提前还款计算器"
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        }
        
        regClass(self.tableView, cell: BaseTableViewCell.self)
        regClass(self.tableView, cell: LoansTypeTableViewCell.self)
        regClass(self.tableView, cell: BottonTableViewCell.self)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PrepaymentCalculatorViewController.backupgroupTap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.cancelsTouchesInView = false
    }
    
    @objc func backupgroupTap() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // MARK: - 计算剩余期数
    @objc func calculateRemainingMonths() {
        guard let loanPeriodStr = self.loanPeriodTextField?.text, !loanPeriodStr.isEmpty,
              let paidMonthsStr = self.paidMonthsTextField?.text, !paidMonthsStr.isEmpty else {
            self.remainingMonthsTextField?.text = "--"
            return
        }
        
        let loanPeriodYears = CGFloat(Double(loanPeriodStr) ?? 0)
        let paidMonths = CGFloat(Double(paidMonthsStr) ?? 0)
        let totalMonths = loanPeriodYears * 12
        let remainingMonths = max(0, totalMonths - paidMonths)
        
        self.remainingMonthsTextField?.text = "\(Int(remainingMonths))"
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4  // 原始贷款信息
        case 1:
            return 3  // 提前还款信息 + 还款方式
        case 2:
            return 1  // 计算按钮
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let cell = getCell(tableView, cell: BottonTableViewCell.self, indexPath: indexPath)
            cell.calculateButton?.addTarget(self, action: #selector(PrepaymentCalculatorViewController.calculateClick), for: .touchUpInside)
            return cell
        }
        
        if indexPath.section == 1 && indexPath.row == 2 {
            let cell = getCell(tableView, cell: LoansTypeTableViewCell.self, indexPath: indexPath)
            self.typeSegmented = cell.typeSegmented
            cell.titleLabel?.text = "还款方式"
            cell.typeSegmented?.setTitle("等额本息", forSegmentAt: 0)
            cell.typeSegmented?.setTitle("等额本金", forSegmentAt: 1)
            cell.bgView.addRoundedCorners(corners: [.bottomLeft, .bottomRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: XZClient.ScreenWidth() - 30, height: 50))
            return cell
        }
        
        let cell = getCell(tableView, cell: BaseTableViewCell.self, indexPath: indexPath)
        
        // 原始贷款信息
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell.titleLabel?.text = "贷款金额（万元）"
                cell.textField?.keyboardType = .numbersAndPunctuation
                self.loanAmountTextField = cell.textField
                cell.bgView.addRoundedCorners(corners: [.topLeft, .topRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: XZClient.ScreenWidth() - 30, height: 50))
            case 1:
                cell.titleLabel?.text = "贷款年限（年）"
                cell.textField?.keyboardType = .numberPad
                cell.textField?.addTarget(self, action: #selector(calculateRemainingMonths), for: .editingChanged)
                self.loanPeriodTextField = cell.textField
            case 2:
                cell.titleLabel?.text = "贷款利率（%）"
                cell.textField?.text = "4.9"
                cell.textField?.keyboardType = .numbersAndPunctuation
                self.loanRateTextField = cell.textField
            case 3:
                cell.titleLabel?.text = "已还期数（月）"
                cell.textField?.keyboardType = .numberPad
                cell.textField?.addTarget(self, action: #selector(calculateRemainingMonths), for: .editingChanged)
                self.paidMonthsTextField = cell.textField
                cell.bgView.addRoundedCorners(corners: [.bottomLeft, .bottomRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: XZClient.ScreenWidth() - 30, height: 50))
            default:
                break
            }
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                cell.titleLabel?.text = "提前还款金额（万元）"
                cell.textField?.keyboardType = .numbersAndPunctuation
                self.prepaymentAmountTextField = cell.textField
                cell.bgView.addRoundedCorners(corners: [.topLeft, .topRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: XZClient.ScreenWidth() - 30, height: 50))
            case 1:
                cell.titleLabel?.text = "剩余期数（系统计算）"
                cell.textField?.text = "--"
                cell.textField?.isEnabled = false
                self.remainingMonthsTextField = cell.textField
            default:
                break
            }
        }
        
        return cell
    }
    
    @objc func calculateClick() {
        self.backupgroupTap()
        
        guard let loanAmountStr = self.loanAmountTextField?.text, !loanAmountStr.isEmpty,
              let loanPeriodStr = self.loanPeriodTextField?.text, !loanPeriodStr.isEmpty,
              let loanRateStr = self.loanRateTextField?.text, !loanRateStr.isEmpty,
              let paidMonthsStr = self.paidMonthsTextField?.text, !paidMonthsStr.isEmpty,
              let prepaymentAmountStr = self.prepaymentAmountTextField?.text, !prepaymentAmountStr.isEmpty else {
            let alert = UIAlertController(title: "提示", message: "请填写完整信息", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let loanAmount = CGFloat(Double(loanAmountStr) ?? 0) * 10000
        let loanPeriod = CGFloat(Double(loanPeriodStr) ?? 0) * 12
        let loanRate = CGFloat(Double(loanRateStr) ?? 0)
        let paidMonths = CGFloat(Double(paidMonthsStr) ?? 0)
        let prepaymentAmount = CGFloat(Double(prepaymentAmountStr) ?? 0) * 10000
        let loanType = self.typeSegmented?.selectedSegmentIndex ?? 0
        
        // 验证提前还款金额不能超过剩余本金
        var remainingPrincipal: CGFloat = 0
        if loanType == 0 {
            remainingPrincipal = LoanModel.averageCapitalPlusInterestRemainingPrincipalTotalInterest(principal: loanAmount, monthRate: loanRate, totalMonths: loanPeriod, numberMonth: paidMonths)
        } else {
            remainingPrincipal = LoanModel.equalPrincipalRemainingPrincipalTotalInterest(principal: loanAmount, monthRate: loanRate, totalMonths: loanPeriod, numberMonth: paidMonths)
        }
        
        if prepaymentAmount > remainingPrincipal {
            let alert = UIAlertController(title: "提示", message: "提前还款金额不能超过剩余本金", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let resultVC = PrepaymentResultViewController()
        resultVC.loanAmountStr = loanAmountStr
        resultVC.loanPeriodStr = loanPeriodStr
        resultVC.loanRateStr = loanRateStr
        resultVC.paidMonthsStr = paidMonthsStr
        resultVC.prepaymentAmountStr = prepaymentAmountStr
        resultVC.loanTypeInt = loanType
        resultVC.hidesBottomBarWhenPushed = true
        
        if let nav = self.rootNavigationController {
            nav.pushViewController(resultVC, animated: true)
        } else {
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
