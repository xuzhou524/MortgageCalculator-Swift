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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.white
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
            self.monthAmountLabel?.text = String.init(format: "%.2f", LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(loanAmountStr)!), monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!)))
            
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.white
        
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
    func bind(loanAmountStr: String, loanNumberStr : String,loanRateStr : String,loanTypeInt : NSInteger){
        switch loanTypeInt {
        case 0:
            self.amountLabel?.text = String.init(format: "%.2f", LoanModel.averageCapitalPlusInterestMonthAmount(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12))
        
        case 1:
            self.amountLabel?.text = String.init(format: "%.2f", LoanModel.equalPrincipalMonthAmount(principal: CGFloat(Double(loanAmountStr)!) * 10000.0, monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!) * 12))
        
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.white
        
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

class LoanDetails_CumulativeTableViewCell: UITableViewCell {
    
    var totalAmountLabel: UILabel?
    var interestRateLabel: UILabel?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.white
        
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
            self.totalAmountLabel?.text = String.init(format: "%.2f", LoanModel.averageCapitalPlusInterestTotalInterest(principal: CGFloat(Double(loanAmountStr)!), monthRate: CGFloat(Double(loanRateStr)!), totalMonths: CGFloat(Double(loanNumberStr)!)))
            
        default: break
        }
    }
}

