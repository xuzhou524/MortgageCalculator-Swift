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
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.periodLabel = UILabel()
        self.periodLabel?.text = "期数"
        self.periodLabel?.font = XZClient.XZFont2(size: 14)
        self.periodLabel?.textColor = XZSwiftColor.xzGlay129
        self.periodLabel?.textAlignment = .center
        self.contentView.addSubview(self.periodLabel!)
        self.periodLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView)
            make.width.equalTo(XZClient.ScreenWidth()/4.0)
        });
        
        self.monthAmountLabel = UILabel()
        self.monthAmountLabel?.text = "月供（元）"
        self.monthAmountLabel?.font = XZClient.XZFont2(size: 14)
        self.monthAmountLabel?.textColor = XZSwiftColor.xzGlay129
        self.monthAmountLabel?.textAlignment = .center
        self.contentView.addSubview(self.monthAmountLabel!)
        self.monthAmountLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo((self.periodLabel?.snp.right)!)
            make.width.equalTo(XZClient.ScreenWidth()/4.0)
        });
        
        self.principalLabel = UILabel()
        self.principalLabel?.text = "本金（元）"
        self.principalLabel?.font = XZClient.XZFont2(size: 14)
        self.principalLabel?.textColor = XZSwiftColor.xzGlay129
        self.principalLabel?.textAlignment = .center
        self.contentView.addSubview(self.principalLabel!)
        self.principalLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo((self.monthAmountLabel?.snp.right)!)
            make.width.equalTo(XZClient.ScreenWidth()/4.0)
        });
        
        self.principalLabel = UILabel()
        self.principalLabel?.text = "利息（元）"
        self.principalLabel?.font = XZClient.XZFont2(size: 14)
        self.principalLabel?.textColor = XZSwiftColor.xzGlay129
        self.principalLabel?.textAlignment = .center
        self.contentView.addSubview(self.principalLabel!)
        self.principalLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo((self.monthAmountLabel?.snp.right)!)
            make.width.equalTo(XZClient.ScreenWidth()/4.0)
        });
        
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
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.titleLabel = UILabel()
        self.titleLabel?.text = "每月月供"
        self.titleLabel?.font = XZClient.XZFont2(size: 14)
        self.titleLabel?.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(self.titleLabel!)
        self.titleLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.contentView.snp.centerY).offset(-5)
            make.left.equalTo(self.contentView).offset(15)
        });
        
        let label = UILabel()
        label.text = "¥"
        label.font = XZClient.XZFont2(size: 18)
        label.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(label)
        label.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.contentView.snp.centerY).offset(5)
            make.left.equalTo(self.titleLabel!)
        });
        
        self.amountLabel = UILabel()
        self.amountLabel?.text = "5647.64"
        self.amountLabel?.font = XZClient.XZFont2(size: 18)
        self.amountLabel?.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(self.amountLabel!)
        self.amountLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(label)
            make.left.equalTo(label.snp.right).offset(5)
        });
        
        let unitLabel = UILabel()
        unitLabel.text = "元"
        unitLabel.font = XZClient.XZFont2(size: 14)
        unitLabel.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(unitLabel)
        unitLabel.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.amountLabel!)
            make.left.equalTo((self.amountLabel?.snp.right)!)
        });
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
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.totalAmountTitleLabel = UILabel()
        self.totalAmountTitleLabel?.text = "贷款总额"
        self.totalAmountTitleLabel?.font = XZClient.XZFont2(size: 14)
        self.totalAmountTitleLabel?.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(self.totalAmountTitleLabel!)
        self.totalAmountTitleLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.contentView.snp.centerY).offset(-5)
            make.left.equalTo(self.contentView).offset(15)
        });
        
        self.totalAmountLabel = UILabel()
        self.totalAmountLabel?.text = "71.6万元"
        self.totalAmountLabel?.font = XZClient.XZFont2(size: 18)
        self.totalAmountLabel?.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(self.totalAmountLabel!)
        self.totalAmountLabel?.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.contentView.snp.centerY).offset(5)
            make.left.equalTo(self.totalAmountTitleLabel!)
        });
        
        self.interestRateTitleLabel = UILabel()
        self.interestRateTitleLabel?.text = "利率"
        self.interestRateTitleLabel?.font = XZClient.XZFont2(size: 14)
        self.interestRateTitleLabel?.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(self.interestRateTitleLabel!)
        self.interestRateTitleLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.totalAmountTitleLabel!)
            make.left.equalTo((self.totalAmountTitleLabel?.snp.right)!).offset(15)
        });
        
        self.interestRateLabel = UILabel()
        self.interestRateLabel?.text = "4.9%"
        self.interestRateLabel?.font = XZClient.XZFont2(size: 18)
        self.interestRateLabel?.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(self.interestRateLabel!)
        self.interestRateLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.totalAmountLabel!)
            make.left.equalTo(self.interestRateTitleLabel!)
        });
        
        self.periodTitleLabel = UILabel()
        self.periodTitleLabel?.text = "利率"
        self.periodTitleLabel?.font = XZClient.XZFont2(size: 14)
        self.periodTitleLabel?.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(self.periodTitleLabel!)
        self.periodTitleLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.totalAmountTitleLabel!)
            make.left.equalTo((self.interestRateTitleLabel?.snp.right)!).offset(15)
        });
        
        self.periodLabel = UILabel()
        self.periodLabel?.text = "4.9%"
        self.periodLabel?.font = XZClient.XZFont2(size: 18)
        self.periodLabel?.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(self.periodLabel!)
        self.periodLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.totalAmountLabel!)
            make.left.equalTo(self.periodTitleLabel!)
        });
        
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
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        let label = UILabel()
        label.text = "累计利息（元）："
        label.font = XZClient.XZFont2(size: 18)
        label.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(label)
        label.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self.contentView.snp.centerY).offset(-5)
            make.left.equalTo(self.contentView)
        });
        
        self.totalAmountLabel = UILabel()
        self.totalAmountLabel?.text = "152432.00"
        self.totalAmountLabel?.font = XZClient.XZFont2(size: 18)
        self.totalAmountLabel?.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(self.totalAmountLabel!)
        self.totalAmountLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(label)
            make.left.equalTo(label).offset(5)
        });
        
        let totalLabel = UILabel()
        totalLabel.text = "累计还款金额（元）："
        totalLabel.font = XZClient.XZFont2(size: 18)
        totalLabel.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(totalLabel)
        totalLabel.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self.contentView.snp.centerY).offset(5)
            make.left.equalTo(self.contentView)
        });
        
        self.interestRateLabel = UILabel()
        self.interestRateLabel?.text = "1245222.00"
        self.interestRateLabel?.font = XZClient.XZFont2(size: 18)
        self.interestRateLabel?.textColor = XZSwiftColor.xzGlay129
        self.contentView.addSubview(self.interestRateLabel!)
        self.interestRateLabel?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(totalLabel)
            make.left.equalTo(totalLabel).offset(5)
        });
    }
}

