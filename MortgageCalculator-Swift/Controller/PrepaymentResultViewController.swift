//
//  PrepaymentResultViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2026/5/24.
//  Copyright © 2026年 com.longdai. All rights reserved.
//

import UIKit

class PrepaymentResultViewController: UITableViewController {
    
    var loanAmountStr: String?
    var loanPeriodStr: String?
    var loanRateStr: String?
    var paidMonthsStr: String?
    var prepaymentAmountStr: String?
    var loanTypeInt: Int = 0
    
    // 计算结果
    private var originalMonthAmount: CGFloat = 0
    private var originalTotalInterest: CGFloat = 0
    private var newMonthAmount: CGFloat = 0
    private var newTotalInterest: CGFloat = 0
    private var interestSaved: CGFloat = 0
    private var remainingPrincipal: CGFloat = 0
    private var remainingMonths: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "提前还款结果"
        self.tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.tableView.separatorStyle = .none
        
        regClass(self.tableView, cell: PrepaymentResultHeaderCell.self)
        regClass(self.tableView, cell: PrepaymentResultCompareCell.self)
        regClass(self.tableView, cell: PrepaymentResultDetailCell.self)
        
        self.calculateResults()
    }
    
    private func calculateResults() {
        guard let loanAmountStr = self.loanAmountStr,
              let loanPeriodStr = self.loanPeriodStr,
              let loanRateStr = self.loanRateStr,
              let paidMonthsStr = self.paidMonthsStr,
              let prepaymentAmountStr = self.prepaymentAmountStr else {
            return
        }
        
        let loanAmount = CGFloat(Double(loanAmountStr) ?? 0) * 10000
        let loanPeriod = CGFloat(Double(loanPeriodStr) ?? 0) * 12
        let loanRate = CGFloat(Double(loanRateStr) ?? 0)
        let paidMonths = CGFloat(Double(paidMonthsStr) ?? 0)
        let prepaymentAmount = CGFloat(Double(prepaymentAmountStr) ?? 0) * 10000
        
        // 原计划计算
        if loanTypeInt == 0 {
            // 等额本息
            originalMonthAmount = LoanModel.averageCapitalPlusInterestMonthAmount(principal: loanAmount, monthRate: loanRate, totalMonths: loanPeriod)
            originalTotalInterest = LoanModel.averageCapitalPlusInterestTotalInterest(principal: loanAmount, monthRate: loanRate, totalMonths: loanPeriod)
            
            // 提前还款后计算
            remainingPrincipal = LoanModel.prepaymentACPIRemainingPrincipal(principal: loanAmount, monthRate: loanRate, totalMonths: loanPeriod, paidMonths: paidMonths, prepaymentAmount: prepaymentAmount)
            remainingMonths = loanPeriod - paidMonths
            
            if remainingPrincipal > 0 && remainingMonths > 0 {
                newMonthAmount = LoanModel.averageCapitalPlusInterestMonthAmount(principal: remainingPrincipal, monthRate: loanRate, totalMonths: remainingMonths)
                newTotalInterest = LoanModel.prepaymentNewTotalInterestACPI(principal: loanAmount, monthRate: loanRate, totalMonths: loanPeriod, paidMonths: paidMonths, prepaymentAmount: prepaymentAmount)
                interestSaved = LoanModel.interestSavedACPI(principal: loanAmount, monthRate: loanRate, totalMonths: loanPeriod, paidMonths: paidMonths, prepaymentAmount: prepaymentAmount)
            }
        } else {
            // 等额本金
            originalMonthAmount = LoanModel.equalPrincipalFirstMonthAmount(principal: loanAmount, monthRate: loanRate, totalMonths: loanPeriod)
            originalTotalInterest = LoanModel.equalPrincipalTotalInterest(principal: loanAmount, monthRate: loanRate, totalMonths: loanPeriod)
            
            // 提前还款后计算
            remainingPrincipal = LoanModel.prepaymentEPRemainingPrincipal(principal: loanAmount, monthRate: loanRate, totalMonths: loanPeriod, paidMonths: paidMonths, prepaymentAmount: prepaymentAmount)
            remainingMonths = loanPeriod - paidMonths
            
            if remainingPrincipal > 0 && remainingMonths > 0 {
                newMonthAmount = LoanModel.equalPrincipalFirstMonthAmount(principal: remainingPrincipal, monthRate: loanRate, totalMonths: remainingMonths)
                newTotalInterest = LoanModel.prepaymentNewTotalInterestEP(principal: loanAmount, monthRate: loanRate, totalMonths: loanPeriod, paidMonths: paidMonths, prepaymentAmount: prepaymentAmount)
                interestSaved = LoanModel.interestSavedEP(principal: loanAmount, monthRate: loanRate, totalMonths: loanPeriod, paidMonths: paidMonths, prepaymentAmount: prepaymentAmount)
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1  // 利息节省标题
        case 1:
            return 1  // 对比表格
        case 2:
            return 5  // 详细信息
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 120
        case 2:
            return 50
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2 {
            return 25
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        let titleLabel = UILabel()
        titleLabel.font = XZClient.XZFont2(size: 14)
        titleLabel.textColor = XZSwiftColor.xzGlay129
        titleLabel.text = ["", "还款对比", "详细信息"][section]
        headerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(8)
        }
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = getCell(tableView, cell: PrepaymentResultHeaderCell.self, indexPath: indexPath)
            cell.bind(interestSaved: interestSaved)
            return cell
        case 1:
            let cell = getCell(tableView, cell: PrepaymentResultCompareCell.self, indexPath: indexPath)
            cell.bind(originalMonthAmount: originalMonthAmount,
                      originalTotalInterest: originalTotalInterest,
                      newMonthAmount: newMonthAmount,
                      newTotalInterest: newTotalInterest)
            return cell
        case 2:
            let cell = getCell(tableView, cell: PrepaymentResultDetailCell.self, indexPath: indexPath)
            cell.bind(index: indexPath.row,
                      loanAmount: CGFloat(Double(loanAmountStr ?? "0") ?? 0) * 10000,
                      remainingPrincipal: remainingPrincipal,
                      remainingMonths: remainingMonths,
                      prepaymentAmount: CGFloat(Double(prepaymentAmountStr ?? "0") ?? 0) * 10000,
                      paidMonths: CGFloat(Double(paidMonthsStr ?? "0") ?? 0))
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 利息节省标题Cell
class PrepaymentResultHeaderCell: UITableViewCell {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ic_theme")
        view.layer.cornerRadius = 10
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 16)
        label.textColor = .white
        label.text = "提前还款可节省利息"
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont3(size: 32)
        label.textColor = .white
        label.text = "¥0.00"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = XZSwiftColor.convenientBackgroundColor
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(amountLabel)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
    
    func bind(interestSaved: CGFloat) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        amountLabel.text = "¥\(formatter.string(from: NSNumber(value: Double(interestSaved))) ?? "0.00")"
    }
}

// MARK: - 还款对比Cell
class PrepaymentResultCompareCell: UITableViewCell {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    // 左边：提前还款前
    let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 14)
        label.textColor = XZSwiftColor.xzGlay129
        label.text = "提前还款前"
        return label
    }()
    
    let originalMonthAmountLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont3(size: 16)
        label.textColor = .black
        return label
    }()
    
    let originalMonthTagLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 12)
        label.textColor = XZSwiftColor.xzGlay129
        label.text = "每月月供"
        return label
    }()
    
    let originalTotalInterestLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont3(size: 16)
        label.textColor = .black
        return label
    }()
    
    let originalInterestTagLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 12)
        label.textColor = XZSwiftColor.xzGlay129
        label.text = "总利息"
        return label
    }()
    
    // 右边：提前还款后
    let newTitleLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 14)
        label.textColor = UIColor(named: "ic_theme")
        label.text = "提前还款后"
        return label
    }()
    
    let newMonthAmountLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont3(size: 16)
        label.textColor = UIColor(named: "ic_theme")
        return label
    }()
    
    let newMonthTagLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 12)
        label.textColor = XZSwiftColor.xzGlay129
        label.text = "每月月供"
        return label
    }()
    
    let newTotalInterestLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont3(size: 16)
        label.textColor = UIColor(named: "ic_theme")
        return label
    }()
    
    let newInterestTagLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 12)
        label.textColor = XZSwiftColor.xzGlay129
        label.text = "总利息"
        return label
    }()
    
    // 中间分隔线
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = XZSwiftColor.convenientBackgroundColor
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(bgView)
        bgView.addSubview(originalTitleLabel)
        bgView.addSubview(originalMonthAmountLabel)
        bgView.addSubview(originalMonthTagLabel)
        bgView.addSubview(originalTotalInterestLabel)
        bgView.addSubview(originalInterestTagLabel)
        bgView.addSubview(dividerLine)
        bgView.addSubview(newTitleLabel)
        bgView.addSubview(newMonthAmountLabel)
        bgView.addSubview(newMonthTagLabel)
        bgView.addSubview(newTotalInterestLabel)
        bgView.addSubview(newInterestTagLabel)
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview()
        }
        
        // 中间分隔线
        dividerLine.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(0.5)
        }
        
        // 左边：提前还款前
        originalTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(15)
        }
        
        originalMonthAmountLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(originalTitleLabel.snp.bottom).offset(12)
        }
        
        originalMonthTagLabel.snp.makeConstraints { make in
            make.left.equalTo(originalMonthAmountLabel.snp.right).offset(4)
            make.bottom.equalTo(originalMonthAmountLabel).offset(-2)
        }
        
        originalTotalInterestLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(originalMonthAmountLabel.snp.bottom).offset(10)
        }
        
        originalInterestTagLabel.snp.makeConstraints { make in
            make.left.equalTo(originalTotalInterestLabel.snp.right).offset(4)
            make.bottom.equalTo(originalTotalInterestLabel).offset(-2)
        }
        
        // 右边：提前还款后
        newTitleLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(15)
        }
        
        newMonthAmountLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(newTitleLabel.snp.bottom).offset(12)
        }
        
        newMonthTagLabel.snp.makeConstraints { make in
            make.right.equalTo(newMonthAmountLabel.snp.left).offset(-4)
            make.bottom.equalTo(newMonthAmountLabel).offset(-2)
        }
        
        newTotalInterestLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(newMonthAmountLabel.snp.bottom).offset(10)
        }
        
        newInterestTagLabel.snp.makeConstraints { make in
            make.right.equalTo(newTotalInterestLabel.snp.left).offset(-4)
            make.bottom.equalTo(newTotalInterestLabel).offset(-2)
        }
    }
    
    func bind(originalMonthAmount: CGFloat, originalTotalInterest: CGFloat, newMonthAmount: CGFloat, newTotalInterest: CGFloat) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        originalMonthAmountLabel.text = "¥\(formatter.string(from: NSNumber(value: Double(originalMonthAmount))) ?? "0.00")"
        newMonthAmountLabel.text = "¥\(formatter.string(from: NSNumber(value: Double(newMonthAmount))) ?? "0.00")"
        originalTotalInterestLabel.text = "¥\(formatter.string(from: NSNumber(value: Double(originalTotalInterest))) ?? "0.00")"
        newTotalInterestLabel.text = "¥\(formatter.string(from: NSNumber(value: Double(newTotalInterest))) ?? "0.00")"
    }
}

// MARK: - 详细信息Cell
class PrepaymentResultDetailCell: UITableViewCell {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 15)
        label.textColor = .black
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 15)
        label.textColor = XZSwiftColor.xzGlay129
        label.textAlignment = .right
        return label
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = XZSwiftColor.convenientBackgroundColor
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(valueLabel)
        bgView.addSubview(bottomLine)
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        
        bottomLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    func bind(index: Int, loanAmount: CGFloat, remainingPrincipal: CGFloat, remainingMonths: CGFloat, prepaymentAmount: CGFloat, paidMonths: CGFloat) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        switch index {
        case 0:
            titleLabel.text = "原始贷款金额"
            valueLabel.text = "¥\(formatter.string(from: NSNumber(value: Double(loanAmount))) ?? "0.00")"
            bgView.addRoundedCorners(corners: [.topLeft, .topRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: XZClient.ScreenWidth() - 30, height: 50))
        case 1:
            titleLabel.text = "已还期数"
            valueLabel.text = "\(Int(paidMonths)) 个月"
        case 2:
            titleLabel.text = "提前还款金额"
            valueLabel.text = "¥\(formatter.string(from: NSNumber(value: Double(prepaymentAmount))) ?? "0.00")"
        case 3:
            titleLabel.text = "剩余本金"
            valueLabel.text = "¥\(formatter.string(from: NSNumber(value: Double(remainingPrincipal))) ?? "0.00")"
        case 4:
            titleLabel.text = "剩余期数"
            valueLabel.text = "\(Int(remainingMonths)) 个月"
            bottomLine.isHidden = true
            bgView.addRoundedCorners(corners: [.bottomLeft, .bottomRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: XZClient.ScreenWidth() - 30, height: 50))
        default:
            break
        }
    }
}