//
//  LoanDetailsTableViewCell.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/10.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class LoanDetailsTableViewCell: UITableViewCell {
    
    var periodLabel: UILabel?
    var monthAmountLabel: UILabel?
    var principalLabel: UILabel?
    var interestLabel: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.selectionStyle = .none
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.periodLabel = UILabel()
        self.periodLabel?.text = "第一期"
        self.periodLabel?.font = XZClient.XZFont2(size: 14)
        self.periodLabel?.textAlignment = .center
        self.contentView.addSubview(self.periodLabel!)
        self.periodLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView)
            make.width.equalTo(XZClient.ScreenWidth()/4.0)
        });
        
        self.monthAmountLabel = UILabel()
        self.monthAmountLabel?.text = "3568.72"
        self.monthAmountLabel?.font = XZClient.XZFont2(size: 14)
        self.monthAmountLabel?.textAlignment = .center
        self.contentView.addSubview(self.monthAmountLabel!)
        self.monthAmountLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo((self.periodLabel?.snp.right)!)
            make.width.equalTo(XZClient.ScreenWidth()/4.0)
        });
        
        self.principalLabel = UILabel()
        self.principalLabel?.text = "989.54"
        self.principalLabel?.font = XZClient.XZFont2(size: 14)
        self.principalLabel?.textAlignment = .center
        self.contentView.addSubview(self.principalLabel!)
        self.principalLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo((self.monthAmountLabel?.snp.right)!)
            make.width.equalTo(XZClient.ScreenWidth()/4.0)
        });
        
        self.interestLabel = UILabel()
        self.interestLabel?.text = "1354.21"
        self.interestLabel?.font = XZClient.XZFont2(size: 14)
        self.interestLabel?.textAlignment = .center
        self.contentView.addSubview(self.interestLabel!)
        self.interestLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo((self.principalLabel?.snp.right)!)
            make.width.equalTo(XZClient.ScreenWidth()/4.0)
        });
        
        let linBView = UIView()
        linBView.backgroundColor = XZSwiftColor.xzGlay230
        self.contentView.addSubview(linBView)
        linBView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0.5);
            make.left.bottom.right.equalTo(self.contentView)
        }
    }
    
    func bind(periodStr: String,loanAmountStr: String, loanNumberStr : String,loanRateStr : String,loanTypeInt : NSInteger){
        self.periodLabel?.text = "第" + periodStr + "期"
        switch loanTypeInt {
        case 0:
            //月供
            self.monthAmountLabel?.text = String.init(format: "%.2f", LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12))
            //每月本金
            self.principalLabel?.text = String.init(format: "%.2f", LoanModel.averageCapitalPlusInterestMonthPrincipal(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!) , totalMonths: CGFloat(Double(loanNumberStr)!) * 12 , numberMonth:CGFloat(Double(periodStr)!)))
            //每月利息
            self.interestLabel?.text = String.init(format: "%.2f", LoanModel.averageCapitalPlusInterestMonthInterest(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!) , totalMonths: CGFloat(Double(loanNumberStr)!) * 12 , numberMonth:CGFloat(Double(periodStr)!)))
        case 1:
            //月供
            self.monthAmountLabel?.text = String.init(format: "%.2f", LoanModel.equalPrincipalMonthAmount(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12,numberMonth:CGFloat(Double(periodStr)!)))
            //每月本金
            self.principalLabel?.text = String.init(format: "%.2f", LoanModel.equalPrincipalMonthPrincipal(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, totalMonths: CGFloat(Double(loanNumberStr)!) * 12))
            //每月利息
            self.interestLabel?.text = String.init(format: "%.2f", LoanModel.equalPrincipalMonthInterest(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!) , totalMonths: CGFloat(Double(loanNumberStr)!) * 12 , numberMonth:CGFloat(Double(periodStr)!)))
        default: break
        }
    }
    
    func binds(periodStr: String,accumulationAmontStr: String, accumulationRateStr : String ,businessAmontStr: String,businessRateStr : String, loanNumberStr : String,loanTypeInt : NSInteger){
        self.periodLabel?.text = "第" + periodStr + "期"
        switch loanTypeInt {
        case 0:
            //月供
            let monthAmonunt = LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(accumulationAmontStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(businessAmontStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12)
            self.monthAmountLabel?.text = String.init(format: "%.2f",monthAmonunt )
            //每月本金
            let principal = LoanModel.averageCapitalPlusInterestMonthPrincipal(principal: CGFloat(Double(accumulationAmontStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!) , totalMonths: CGFloat(Double(loanNumberStr)!) * 12 , numberMonth:CGFloat(Double(periodStr)!)) + LoanModel.averageCapitalPlusInterestMonthPrincipal(principal: CGFloat(Double(businessAmontStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!) , totalMonths: CGFloat(Double(loanNumberStr)!) * 12 , numberMonth:CGFloat(Double(periodStr)!))
            self.principalLabel?.text = String.init(format: "%.2f", principal)
            //每月利息
            let interest = LoanModel.averageCapitalPlusInterestMonthInterest(principal: CGFloat(Double(accumulationAmontStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!) , totalMonths: CGFloat(Double(loanNumberStr)!) * 12 , numberMonth:CGFloat(Double(periodStr)!)) + LoanModel.averageCapitalPlusInterestMonthInterest(principal: CGFloat(Double(businessAmontStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!) , totalMonths: CGFloat(Double(loanNumberStr)!) * 12 , numberMonth:CGFloat(Double(periodStr)!))
            self.interestLabel?.text = String.init(format: "%.2f", interest)
        case 1:
            //月供
            let monthAmonunt = LoanModel.equalPrincipalMonthAmount(principal: CGFloat(Double(accumulationAmontStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12,numberMonth:CGFloat(Double(periodStr)!)) + LoanModel.equalPrincipalMonthAmount(principal: CGFloat(Double(businessAmontStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12,numberMonth:CGFloat(Double(periodStr)!))
            self.monthAmountLabel?.text = String.init(format: "%.2f", monthAmonunt)
            //每月本金
            let principal = LoanModel.equalPrincipalMonthPrincipal(principal: CGFloat(Double(accumulationAmontStr)!) * 10000.0, totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + LoanModel.equalPrincipalMonthPrincipal(principal: CGFloat(Double(businessAmontStr)!) * 10000.0, totalMonths: CGFloat(Double(loanNumberStr)!) * 12)
            self.principalLabel?.text = String.init(format: "%.2f", principal)
            //每月利息
            let interest =  LoanModel.equalPrincipalMonthInterest(principal: CGFloat(Double(accumulationAmontStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!) , totalMonths: CGFloat(Double(loanNumberStr)!) * 12 , numberMonth:CGFloat(Double(periodStr)!)) + LoanModel.equalPrincipalMonthInterest(principal: CGFloat(Double(businessAmontStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!) , totalMonths: CGFloat(Double(loanNumberStr)!) * 12 , numberMonth:CGFloat(Double(periodStr)!))
            self.interestLabel?.text = String.init(format: "%.2f", interest)
        default: break
        }
    }
}


class LoanDetailsTitleTableView: UIView {
    
    var periodLabel: UILabel?
    var monthAmountLabel: UILabel?
    var principalLabel: UILabel?
    var interestLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.backgroundColor = XZSwiftColor.xzGlay230

        self.periodLabel = UILabel()
        self.periodLabel?.text = "期数"
        self.periodLabel?.font = XZClient.XZFont2(size: 14)
        self.periodLabel?.textAlignment = .center
        self.addSubview(self.periodLabel!)
        self.periodLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self)
            make.left.equalTo(self)
            make.width.equalTo(XZClient.ScreenWidth()/4.0)
        });
        
        self.monthAmountLabel = UILabel()
        self.monthAmountLabel?.text = "月供（元）"
        self.monthAmountLabel?.font = XZClient.XZFont2(size: 14)
        self.monthAmountLabel?.textAlignment = .center
        self.addSubview(self.monthAmountLabel!)
        self.monthAmountLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self)
            make.left.equalTo((self.periodLabel?.snp.right)!)
            make.width.equalTo(XZClient.ScreenWidth()/4.0)
        });
        
        self.principalLabel = UILabel()
        self.principalLabel?.text = "本金（元）"
        self.principalLabel?.font = XZClient.XZFont2(size: 14)
        self.principalLabel?.textAlignment = .center
        self.addSubview(self.principalLabel!)
        self.principalLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self)
            make.left.equalTo((self.monthAmountLabel?.snp.right)!)
            make.width.equalTo(XZClient.ScreenWidth()/4.0)
        });
        
        self.interestLabel = UILabel()
        self.interestLabel?.text = "利息（元）"
        self.interestLabel?.font = XZClient.XZFont2(size: 14)
        self.interestLabel?.textAlignment = .center
        self.addSubview(self.interestLabel!)
        self.interestLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self)
            make.left.equalTo((self.principalLabel?.snp.right)!)
            make.width.equalTo(XZClient.ScreenWidth()/4.0)
        });
        
        let linBView = UIView()
        linBView.backgroundColor = XZSwiftColor.xzGlay230
        self.addSubview(linBView)
        linBView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0.5);
            make.left.bottom.right.equalTo(self)
        }
    }
}

class LoanDetails_TitleTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel?
    var amountLabel: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.selectionStyle = .none
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.titleLabel = UILabel()
        self.titleLabel?.text = "每月月供"
        self.titleLabel?.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(self.titleLabel!)
        self.titleLabel?.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.contentView).offset(15)
            make.left.equalTo(self.contentView).offset(15)
        });
        
        let label = UILabel()
        label.text = "¥"
        label.font = XZClient.XZFont2(size: 20)
        self.contentView.addSubview(label)
        label.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo((self.titleLabel?.snp.bottom)!).offset(13)
            make.left.equalTo(self.titleLabel!)
        });
        
        self.amountLabel = UILabel()
        self.amountLabel?.text = "5647.64"
        self.amountLabel?.font = XZClient.XZFont2(size: 22)
        self.contentView.addSubview(self.amountLabel!)
        self.amountLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(label)
            make.left.equalTo(label.snp.right).offset(3)
        });
        
        let unitLabel = UILabel()
        unitLabel.text = "元"
        unitLabel.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(unitLabel)
        unitLabel.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.amountLabel!).offset(-2)
            make.left.equalTo((self.amountLabel?.snp.right)!)
        });
    }
    
    func bind(loanAmountStr: String , loanNumberStr : String,loanRateStr : String,loanTypeInt : NSInteger){
        switch loanTypeInt {
        case 0:
            self.titleLabel?.text = "每月月供"
            self.amountLabel?.text = String.init(format: "%.2f", LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12))
        case 1:
            self.titleLabel?.text = "首月月供"
            self.amountLabel?.text = String.init(format: "%.2f", LoanModel.equalPrincipalFirstMonthAmount(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12))
        default: break
        }
    }
    
    func binds(accumulationAmontStr: String, accumulationRateStr : String ,businessAmontStr: String,businessRateStr : String, loanNumberStr : String,loanTypeInt : NSInteger){
        switch loanTypeInt {
        case 0:
            self.titleLabel?.text = "每月月供"
            let monthAlso = LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(accumulationAmontStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(businessAmontStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12)
            self.amountLabel?.text = String.init(format: "%.2f", monthAlso)
        case 1:
            self.titleLabel?.text = "首月月供"
            let monthAlso = LoanModel.equalPrincipalFirstMonthAmount(principal: CGFloat(Double(accumulationAmontStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + LoanModel.equalPrincipalFirstMonthAmount(principal: CGFloat(Double(businessAmontStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12)
            self.amountLabel?.text = String.init(format: "%.2f", monthAlso)
        default: break
        }
    }
}

class LoanNextMouth_TitleTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel?
    
    var amountLabel: UILabel?
    var principalAmountLabel: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.selectionStyle = .none
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.titleLabel = UILabel()
        self.titleLabel?.text = "下次月供"
        self.titleLabel?.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(self.titleLabel!)
        self.titleLabel?.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.contentView).offset(15)
            make.left.equalTo(self.contentView).offset(15)
        });
        
        let label = UILabel()
        label.text = "¥"
        label.font = XZClient.XZFont2(size: 20)
        self.contentView.addSubview(label)
        label.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo((self.titleLabel?.snp.bottom)!).offset(13)
            make.left.equalTo(self.titleLabel!)
        });
        
        self.amountLabel = UILabel()
        self.amountLabel?.text = "5647.64"
        self.amountLabel?.font = XZClient.XZFont2(size: 22)
        self.contentView.addSubview(self.amountLabel!)
        self.amountLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(label)
            make.left.equalTo(label.snp.right).offset(3)
        });
        
        let unitLabel = UILabel()
        unitLabel.text = "元"
        unitLabel.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(unitLabel)
        unitLabel.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.amountLabel!).offset(-2)
            make.left.equalTo((self.amountLabel?.snp.right)!)
        });
        
        let principalLabel = UILabel()
        principalLabel.text = "剩余本金（元）"
        principalLabel.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(principalLabel)
        principalLabel.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.contentView).offset(15)
            make.left.equalTo(self.titleLabel!).offset(150)
        });
        
        self.principalAmountLabel = UILabel()
        self.principalAmountLabel?.text = "5647.64"
        self.principalAmountLabel?.font = XZClient.XZFont2(size: 22)
        self.contentView.addSubview(self.principalAmountLabel!)
        self.principalAmountLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(label)
            make.left.equalTo(principalLabel)
        });
    }
    
    func bind(loanAmountStr: String , loanNumberStr : String,loanRateStr : String,loanTypeInt : NSInteger ,numberMonth : NSInteger){
        switch loanTypeInt {
        case 0:
            self.amountLabel?.text = String.init(format: "%.2f", LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12))
            self.principalAmountLabel?.text = String.init(format: "%.2f", LoanModel.averageCapitalPlusInterestRemainingPrincipalTotalInterest(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12, numberMonth: CGFloat(Double(numberMonth))))
        case 1:
            self.amountLabel?.text = String.init(format: "%.2f", LoanModel.equalPrincipalMonthAmount(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12, numberMonth: CGFloat(numberMonth) + 1.0))
            self.principalAmountLabel?.text = String.init(format: "%.2f", LoanModel.equalPrincipalRemainingPrincipalTotalInterest(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12, numberMonth: CGFloat(Double(numberMonth))))
        default: break
        }
    }
    
    func binds(accumulationAmontStr: String, accumulationRateStr : String ,businessAmontStr: String,businessRateStr : String, loanNumberStr : String,loanTypeInt : NSInteger , numberMonth : NSInteger) {
        switch loanTypeInt {
        case 0:
            let monthAlso = LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(accumulationAmontStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(businessAmontStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12)
            self.amountLabel?.text = String.init(format: "%.2f", monthAlso)
        case 1:
            let monthAlso = LoanModel.equalPrincipalMonthAmount(principal: CGFloat(Double(accumulationAmontStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12 , numberMonth: CGFloat(numberMonth) + 1.0) + LoanModel.equalPrincipalMonthAmount(principal: CGFloat(Double(businessAmontStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12 , numberMonth: CGFloat(numberMonth) + 1.0)
            self.amountLabel?.text = String.init(format: "%.2f", monthAlso)
        default: break
        }
    }
}

class LoanDetails_DescribeTableViewCell: UITableViewCell {
    
    var totalAmountTitleLabel: UILabel?
    var totalAmountLabel: UILabel?
    
    var interestRateTitleLabel: UILabel?
    var interestRateLabel: UILabel?
    
    var periodTitleLabel: UILabel?
    var periodLabel: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.selectionStyle = .none
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.totalAmountTitleLabel = UILabel()
        self.totalAmountTitleLabel?.text = "贷款总额"
        self.totalAmountTitleLabel?.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(self.totalAmountTitleLabel!)
        self.totalAmountTitleLabel?.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.contentView).offset(17)
            make.left.equalTo(self.contentView).offset(15)
        });
        
        self.totalAmountLabel = UILabel()
        self.totalAmountLabel?.text = "710.6万元"
        self.totalAmountLabel?.font = XZClient.XZFont2(size: 18)
        self.contentView.addSubview(self.totalAmountLabel!)
        self.totalAmountLabel?.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.contentView.snp.centerY).offset(6)
            make.left.equalTo(self.totalAmountTitleLabel!)
        });
        
        self.interestRateTitleLabel = UILabel()
        self.interestRateTitleLabel?.text = "利率"
        self.interestRateTitleLabel?.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(self.interestRateTitleLabel!)
        self.interestRateTitleLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.totalAmountTitleLabel!)
            make.left.equalTo((self.totalAmountTitleLabel?.snp.right)!).offset(40)
        });
        
        self.interestRateLabel = UILabel()
        self.interestRateLabel?.text = "4.9%"
        self.interestRateLabel?.font = XZClient.XZFont2(size: 18)
        self.contentView.addSubview(self.interestRateLabel!)
        self.interestRateLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.totalAmountLabel!)
            make.left.equalTo(self.interestRateTitleLabel!)
        });
        
        self.periodTitleLabel = UILabel()
        self.periodTitleLabel?.text = "贷款年限"
        self.periodTitleLabel?.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(self.periodTitleLabel!)
        self.periodTitleLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.totalAmountTitleLabel!)
            make.left.equalTo((self.interestRateTitleLabel?.snp.right)!).offset(40)
        });
        
        self.periodLabel = UILabel()
        self.periodLabel?.text = "30"
        self.periodLabel?.font = XZClient.XZFont2(size: 18)
        self.contentView.addSubview(self.periodLabel!)
        self.periodLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.totalAmountLabel!)
            make.left.equalTo(self.periodTitleLabel!)
        });
    }
    
    func bind(loanAmountStr: String, loanNumberStr : String,loanRateStr : String){
        self.totalAmountLabel?.text = loanAmountStr + "万元"
        self.interestRateLabel?.text = loanRateStr + "%"
        self.periodLabel?.text = loanNumberStr + "年"
    }
}

class LoanDetails_DescribesTableViewCell: UITableViewCell {
    
    var accumulationAmountTitleLabel: UILabel?
    var accumulationAmountLabel: UILabel?
    
    var accumulationRateTitleLabel: UILabel?
    var accumulationRateLabel: UILabel?
    
    var accumulationPeriodTitleLabel: UILabel?
    var accumulationPeriodLabel: UILabel?
    
    var businessAmountTitleLabel: UILabel?
    var businessAmountLabel: UILabel?
    
    var businessRateTitleLabel: UILabel?
    var businessRateLabel: UILabel?
    
    var businessPeriodTitleLabel: UILabel?
    var businessPeriodLabel: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.selectionStyle = .none
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.accumulationAmountTitleLabel = UILabel()
        self.accumulationAmountTitleLabel?.text = "公积金贷款总额"
        self.accumulationAmountTitleLabel?.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(self.accumulationAmountTitleLabel!)
        self.accumulationAmountTitleLabel?.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.contentView).offset(17)
            make.left.equalTo(self.contentView).offset(15)
        });
        
        self.accumulationAmountLabel = UILabel()
        self.accumulationAmountLabel?.text = "710.6万元"
        self.accumulationAmountLabel?.font = XZClient.XZFont2(size: 18)
        self.contentView.addSubview(self.accumulationAmountLabel!)
        self.accumulationAmountLabel?.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo((self.accumulationAmountTitleLabel?.snp.bottom)!).offset(8)
            make.left.equalTo(self.accumulationAmountTitleLabel!)
        });
        
        self.businessAmountTitleLabel = UILabel()
        self.businessAmountTitleLabel?.text = "商业贷款总额"
        self.businessAmountTitleLabel?.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(self.businessAmountTitleLabel!)
        self.businessAmountTitleLabel?.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo((self.accumulationAmountLabel?.snp.bottom)!).offset(15)
            make.left.equalTo(self.accumulationAmountLabel!)
        });
        
        self.businessAmountLabel = UILabel()
        self.businessAmountLabel?.text = "710.6万元"
        self.businessAmountLabel?.font = XZClient.XZFont2(size: 18)
        self.contentView.addSubview(self.businessAmountLabel!)
        self.businessAmountLabel?.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo((self.businessAmountTitleLabel?.snp.bottom)!).offset(8)
            make.left.equalTo(self.businessAmountTitleLabel!)
        });
        
        self.accumulationRateTitleLabel = UILabel()
        self.accumulationRateTitleLabel?.text = "公积金利率"
        self.accumulationRateTitleLabel?.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(self.accumulationRateTitleLabel!)
        self.accumulationRateTitleLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.accumulationAmountTitleLabel!)
            make.left.equalTo((self.accumulationAmountTitleLabel?.snp.right)!).offset(30)
        });
        
        self.businessRateTitleLabel = UILabel()
        self.businessRateTitleLabel?.text = "商业利率"
        self.businessRateTitleLabel?.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(self.businessRateTitleLabel!)
        self.businessRateTitleLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.businessAmountTitleLabel!)
            make.left.equalTo(self.accumulationRateTitleLabel!)
        });
        
        self.accumulationRateLabel = UILabel()
        self.accumulationRateLabel?.text = "4.9%"
        self.accumulationRateLabel?.font = XZClient.XZFont2(size: 18)
        self.contentView.addSubview(self.accumulationRateLabel!)
        self.accumulationRateLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.accumulationAmountLabel!)
            make.left.equalTo(self.accumulationRateTitleLabel!)
        });
        
        self.businessRateLabel = UILabel()
        self.businessRateLabel?.text = "4.9%"
        self.businessRateLabel?.font = XZClient.XZFont2(size: 18)
        self.contentView.addSubview(self.businessRateLabel!)
        self.businessRateLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.businessAmountLabel!)
            make.left.equalTo(self.businessRateTitleLabel!)
        });
        
        self.accumulationPeriodTitleLabel = UILabel()
        self.accumulationPeriodTitleLabel?.text = "公积金贷款年限"
        self.accumulationPeriodTitleLabel?.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(self.accumulationPeriodTitleLabel!)
        self.accumulationPeriodTitleLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.accumulationAmountTitleLabel!)
            make.left.equalTo((self.accumulationRateTitleLabel?.snp.right)!).offset(30)
        });
        
        self.businessPeriodTitleLabel = UILabel()
        self.businessPeriodTitleLabel?.text = "商业贷款年限"
        self.businessPeriodTitleLabel?.font = XZClient.XZFont2(size: 14)
        self.contentView.addSubview(self.businessPeriodTitleLabel!)
        self.businessPeriodTitleLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.businessAmountTitleLabel!)
            make.left.equalTo(self.accumulationPeriodTitleLabel!)
        });
        
        self.accumulationPeriodLabel = UILabel()
        self.accumulationPeriodLabel?.text = "30"
        self.accumulationPeriodLabel?.font = XZClient.XZFont2(size: 18)
        self.contentView.addSubview(self.accumulationPeriodLabel!)
        self.accumulationPeriodLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.accumulationAmountLabel!)
            make.left.equalTo(self.accumulationPeriodTitleLabel!)
        });
        
        self.businessPeriodLabel = UILabel()
        self.businessPeriodLabel?.text = "30"
        self.businessPeriodLabel?.font = XZClient.XZFont2(size: 18)
        self.contentView.addSubview(self.businessPeriodLabel!)
        self.businessPeriodLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.businessAmountLabel!)
            make.left.equalTo(self.businessPeriodTitleLabel!)
        });
    }
    
    func bind(businessAmountStr: String,businessRateStr: String,accumulationAmountStr: String,accumulationRateStr : String, loanNumberStr : String){
        self.accumulationAmountLabel?.text = accumulationAmountStr + "万元"
        self.accumulationRateLabel?.text = accumulationRateStr + "%"
        self.accumulationPeriodLabel?.text = loanNumberStr + "年"
        
        self.businessAmountLabel?.text = businessAmountStr + "万元"
        self.businessRateLabel?.text = businessRateStr + "%"
        self.businessPeriodLabel?.text = loanNumberStr + "年"
    }
}

class LoanDetails_CumulativeTableViewCell: UITableViewCell {
    
    var totalAmountLabel: UILabel?
    var interestRateLabel: UILabel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.selectionStyle = .none
        
        let linView = UIView()
        linView.backgroundColor = XZSwiftColor.xzGlay230
        self.contentView.addSubview(linView)
        linView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0.5);
            make.left.top.right.equalTo(self.contentView)
        }
        
        let label = UILabel()
        label.text = "累计利息（元）："
        label.font = XZClient.XZFont2(size: 15)
        self.contentView.addSubview(label)
        label.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.contentView).offset(15)
            make.left.equalTo(self.contentView).offset(15)
        });
        
        self.totalAmountLabel = UILabel()
        self.totalAmountLabel?.text = "152432.00"
        self.totalAmountLabel?.font = XZClient.XZFont2(size: 15)
        self.contentView.addSubview(self.totalAmountLabel!)
        self.totalAmountLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(label)
            make.left.equalTo(label.snp.right).offset(5)
        });
        
        let totalLabel = UILabel()
        totalLabel.text = "累计还款金额（元）："
        totalLabel.font = XZClient.XZFont2(size: 15)
        self.contentView.addSubview(totalLabel)
        totalLabel.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(label.snp.bottom).offset(15)
            make.left.equalTo(self.contentView).offset(15)
        });
        
        self.interestRateLabel = UILabel()
        self.interestRateLabel?.text = "1245222.00"
        self.interestRateLabel?.font = XZClient.XZFont2(size: 15)
        self.contentView.addSubview(self.interestRateLabel!)
        self.interestRateLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(totalLabel)
            make.left.equalTo(totalLabel.snp.right).offset(5)
        });
        
        let linBView = UIView()
        linBView.backgroundColor = XZSwiftColor.xzGlay230
        self.contentView.addSubview(linBView)
        linBView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0.5);
            make.left.bottom.right.equalTo(self.contentView)
        }
    }
    
    func bind(loanAmountStr: String, loanNumberStr : String,loanRateStr : String,loanTypeInt : NSInteger){
        switch loanTypeInt {
        case 0:
            self.totalAmountLabel?.text = String.init(format: "%.2f", LoanModel.averageCapitalPlusInterestTotalInterest(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12))
            self.interestRateLabel?.text = String.init(format: "%.2f", LoanModel.averageCapitalPlusInterestTotalInterest(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + CGFloat(Double(loanAmountStr)!) * 10000.0)
        case 1:
            self.totalAmountLabel?.text = String.init(format: "%.2f", LoanModel.equalPrincipalTotalInterest(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12))
            self.interestRateLabel?.text = String.init(format: "%.2f", LoanModel.equalPrincipalTotalInterest(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + CGFloat(Double(loanAmountStr)!) * 10000.0)
            
        default: break
        }
    }
    
    func binds(businessAmountStr: String,businessRateStr: String,accumulationAmountStr: String,accumulationRateStr : String, loanNumberStr : String,loanTypeInt : NSInteger){
        switch loanTypeInt {
        case 0:
            let monthAlso = LoanModel.averageCapitalPlusInterestTotalInterest(principal: CGFloat(Double(businessAmountStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + LoanModel.averageCapitalPlusInterestTotalInterest(principal: CGFloat(Double(accumulationAmountStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12)
            self.totalAmountLabel?.text = String.init(format: "%.2f", monthAlso)
            
            let nterestRateMonthAlso = LoanModel.averageCapitalPlusInterestTotalInterest(principal: CGFloat(Double(businessAmountStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + CGFloat(Double(businessAmountStr)!) * 10000.0 + LoanModel.averageCapitalPlusInterestTotalInterest(principal: CGFloat(Double(accumulationAmountStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + CGFloat(Double(accumulationAmountStr)!) * 10000.0
            self.interestRateLabel?.text = String.init(format: "%.2f", nterestRateMonthAlso)
            
        case 1:
            let monthAlso = LoanModel.equalPrincipalTotalInterest(principal: CGFloat(Double(businessAmountStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + LoanModel.equalPrincipalTotalInterest(principal: CGFloat(Double(accumulationAmountStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12)
            
            self.totalAmountLabel?.text = String.init(format: "%.2f",monthAlso)
            
            let nterestRateMonthAlso = LoanModel.equalPrincipalTotalInterest(principal: CGFloat(Double(businessAmountStr)!) * 10000.0, monthRate: CGFloat(Double(businessRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + CGFloat(Double(businessAmountStr)!) * 10000.0 + LoanModel.equalPrincipalTotalInterest(principal: CGFloat(Double(accumulationAmountStr)!) * 10000.0, monthRate: CGFloat(Double(accumulationRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12) + CGFloat(Double(accumulationAmountStr)!) * 10000.0
            self.interestRateLabel?.text = String.init(format: "%.2f", nterestRateMonthAlso)
            
        default: break
        }
    }

}

