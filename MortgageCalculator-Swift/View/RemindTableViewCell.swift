//
//  RemindTableViewCell.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/21.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class RemindTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class RemindDayTitleView: UIView {
    
    var leftLinSepView : UIView?
    var rightLinSepView : UIView?
    var backgroundView : UIImageView?
    
    var titleLabel : UILabel?
    var dayLabel : UILabel?
    var dayTitleLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.backgroundView = UIImageView()
        self.backgroundView?.image = UIImage.init(named: "ic_MyLoanBg")
        self.addSubview(self.backgroundView!)
        self.backgroundView?.snp.makeConstraints({ (make) -> Void in
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(170)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
        });

        self.backgroundView?.layer.cornerRadius = 10
        self.backgroundView?.layer.masksToBounds = true
        
        self.titleLabel = UILabel()
        self.titleLabel?.text = "距离还款日还有"
        self.titleLabel?.textColor = XZSwiftColor.white
        self.titleLabel?.font = XZClient.XZFont(size: 16)
        self.backgroundView?.addSubview(self.titleLabel!)
        self.titleLabel?.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.backgroundView!)
            make.top.equalTo(self.backgroundView!).offset(15)
        }
        
        self.dayLabel = UILabel()
        self.dayLabel?.text = "暂无"
        self.dayLabel?.textColor = XZSwiftColor.white
        self.dayLabel?.font = XZClient.XZFont(size: 50)
        self.backgroundView?.addSubview(self.dayLabel!)
        self.dayLabel?.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.backgroundView!).offset(-5)
            make.top.equalTo((self.titleLabel?.snp.bottom)!).offset(20)
        }
        
        self.dayTitleLabel = UILabel()
        self.dayTitleLabel?.text = "天"
        self.dayTitleLabel?.textColor = XZSwiftColor.white
        self.dayTitleLabel?.font = XZClient.XZFont(size: 14)
        self.backgroundView?.addSubview(self.dayTitleLabel!)
        self.dayTitleLabel?.snp.makeConstraints { (make) in
            make.left.equalTo((self.dayLabel?.snp.right)!).offset(6)
            make.bottom.equalTo(self.dayLabel!).offset(-6)
        }
        
        let summeryLabel = UILabel()
        summeryLabel.text = "*注: 还款日前1天会提醒，防止逾期影响您的征信。"
        summeryLabel.textColor = XZSwiftColor.white
        summeryLabel.font = XZClient.XZFont(size: 12)
        self.backgroundView?.addSubview(summeryLabel)
        summeryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.backgroundView!).offset(15)
            make.bottom.equalTo(self.backgroundView!).offset(-20)
        }
    }
}

