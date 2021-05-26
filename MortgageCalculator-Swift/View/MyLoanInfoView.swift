//
//  MyLoanInfoView.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2021/5/26.
//  Copyright © 2021 com.longdai. All rights reserved.
//

import UIKit

class MyLoanInfoView: UIView {
    
    let bgImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "ic_MyLoanBg")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let amountTLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 13)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "下次月供"
        return label
    }()
    let conformTLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 18)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "¥"
        return label
    }()
    let amountLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 26)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "3528.43"
        return label
    }()
    
    let dayTLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 13)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "天后"
        return label
    }()
    let dayLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 38)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "23"
        return label
    }()
    
    let timeLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 13)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "2021年06月15日"
        return label
    }()
    
    let summeryLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 13)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "*注: 还款日前1天有提醒"
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        sebViews()
    }
    
    func sebViews() {
        
        self.addSubview(bgImageView)

        bgImageView.addSubview(amountLabel)
        bgImageView.addSubview(conformTLabel)
        bgImageView.addSubview(amountTLabel)
        bgImageView.addSubview(dayTLabel)
        bgImageView.addSubview(dayLabel)
        bgImageView.addSubview(timeLabel)
        bgImageView.addSubview(summeryLabel)

        bgImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-10)
        }
        conformTLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview().offset(-10)
        }
        amountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(conformTLabel.snp.right).offset(2)
            make.bottom.equalTo(conformTLabel).offset(1)
        }
        amountTLabel.snp.makeConstraints { (make) in
            make.left.equalTo(conformTLabel)
            make.bottom.equalTo(amountLabel.snp.top).offset(-6)
        }
        
        
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(amountLabel).offset(15)
        }
        
        dayTLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(timeLabel.snp.top).offset(-10)
        }
        dayLabel.snp.makeConstraints { (make) in
            make.right.equalTo(dayTLabel.snp.left).offset(-5)
            make.bottom.equalTo(dayTLabel).offset(3)
        }

        summeryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(amountTLabel)
            make.bottom.equalToSuperview().offset(-20)
        }

    }
    func bind(model:LoanCacheManage?){
        if model != nil{
            //计算剩余天
            var dayStr = String()
            var monthStr = "01"
            let calendar: Calendar = Calendar(identifier: .gregorian)
            var comps: DateComponents = DateComponents()
            comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
    
            if (comps.month == 12) {
                monthStr = "01"
                dayStr = String(comps.year! + 1) + "01" + (model?.repaymentDateStr)!
            }else if (comps.month! < 9) {
                monthStr = String(comps.month! + 1)
                dayStr = String(comps.year!) + "0" + String(comps.month! + 1) + (model?.repaymentDateStr)!
            }else{
                monthStr = String(comps.month! + 1)
                dayStr = String(comps.year!) + String(comps.month! + 1) + (model?.repaymentDateStr)!
            }
            let dfmatter = DateFormatter()
            dfmatter.dateFormat="yyyyMMdd"
            //首次还款时间戳
            let dayStrs = dfmatter.date(from:dayStr)
            let gregorians = Calendar.init(identifier: .gregorian)
            let dayNumber = gregorians.dateComponents([.month , .day , .hour], from:Date(), to:dayStrs!)
            if dayNumber.day == 0 {
                self.dayLabel.text = "明天"
                self.dayTLabel.text = ""
            }else{
                self.dayLabel.text = String(dayNumber.day!)
                self.dayTLabel.text = "天后"
            }
            
            //下次还款日期
            self.timeLabel.text = "\(comps.year ?? 0000)年\(monthStr)月\(model?.repaymentDateStr ?? "00")日"
            
            //金额
            let loanType = NSInteger(model?.loanTypeStr ?? "1")
            if loanType == 1 || loanType == 2 {
                let reimbursementType = NSInteger(model?.reimbursementTypeStr ?? "0")
                let loanAmountStr = model?.businessPrincipalStr ?? "0"
                let loanRateStr = model?.businessRateStr ?? "0"
                let loanNumberStr = model?.numberYearStr ?? "0"
                if reimbursementType == 0 {
                    self.amountLabel.text = String.init(format: "%.2f", LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12))
                }else{
                    let numberMonth = model?.alsoNumberMonthStr ?? "0"
                    self.amountLabel.text = String.init(format: "%.2f", LoanModel.equalPrincipalMonthAmount(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12, numberMonth: 1.0 + CGFloat(Double(numberMonth)!)))
                }
            }else if loanType == 3 {
                
                let reimbursementType = NSInteger(model?.reimbursementTypeStr ?? "0")
                
                let accumulationAmontStr = model?.accumulationPrincipalStr ?? "0"
                let accumulationRateStr = model?.accumulationRateStr ?? "0"
                let loanNumberStr = model?.numberYearStr ?? "0"
                let businessAmontStr = model?.businessPrincipalStr ?? "0"
                let businessRateStr = model?.businessRateStr ?? "0"
                
                if reimbursementType == 0 {
                    let monthAlso = LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(accumulationAmontStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(businessAmontStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12)
                    self.amountLabel.text = String.init(format: "%.2f", monthAlso)
                }else{
                    let numberMonth = model?.alsoNumberMonthStr ?? "0"
                    let monthAlso = LoanModel.equalPrincipalMonthAmount(principal: CGFloat(Double(accumulationAmontStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12 , numberMonth: 1.0 + CGFloat(Double(numberMonth)!)) + LoanModel.equalPrincipalMonthAmount(principal: CGFloat(Double(businessAmontStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12 , numberMonth: 1.0 + CGFloat(Double(numberMonth)!))
                    self.amountLabel.text = String.init(format: "%.2f", monthAlso)
                }
            }
        }
    }
}
