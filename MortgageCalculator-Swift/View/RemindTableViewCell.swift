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
    var backgroundView : UIView?
    
    var titleLabel : UILabel?
    var dayLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        
        self.leftLinSepView = UIView()
        self.leftLinSepView?.backgroundColor = XZSwiftColor.xzGlay129
        self.addSubview(self.leftLinSepView!)
        self.leftLinSepView?.snp.makeConstraints({ (make) -> Void in
            make.centerX.equalTo(self).offset(-100)
            make.width.equalTo(2)
            make.top.equalTo(self)
            make.height.equalTo(80)
        });
        self.leftLinSepView?.layer.shadowOpacity = 1
        self.leftLinSepView?.layer.shadowColor = XZSwiftColor.xzGlay129.cgColor
        self.leftLinSepView?.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        
        self.rightLinSepView = UIView()
        self.rightLinSepView?.backgroundColor = XZSwiftColor.xzGlay129
        self.addSubview(self.rightLinSepView!)
        self.rightLinSepView?.snp.makeConstraints({ (make) -> Void in
            make.centerX.equalTo(self).offset(100)
            make.width.equalTo(2)
            make.top.equalTo(self)
            make.height.equalTo(80)
        });
        self.rightLinSepView?.layer.shadowOpacity = 1
        self.rightLinSepView?.layer.shadowColor = XZSwiftColor.xzGlay129.cgColor
        self.rightLinSepView?.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        
        self.backgroundView = UIView()
        self.backgroundView?.backgroundColor = XZSwiftColor.xzGlay129
        self.addSubview(self.backgroundView!)
        self.backgroundView?.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo((self.leftLinSepView?.snp.bottom)!)
            make.height.equalTo(170)
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).offset(-30)
        });
        self.backgroundView?.layer.masksToBounds = true
        self.backgroundView?.layer.cornerRadius = 3
        self.backgroundView?.layer.shadowOpacity = 0.8
        self.backgroundView?.layer.shadowColor = XZSwiftColor.xzGlay129.cgColor
        self.backgroundView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.backgroundView?.layer.shadowRadius = 2
        
        self.titleLabel = UILabel()
        self.titleLabel?.text = "距离还款日还有"
        self.titleLabel?.textColor = XZSwiftColor.white
        self.titleLabel?.font = XZClient.XZFont(size: 18)
        self.backgroundView?.addSubview(self.titleLabel!)
        self.titleLabel?.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.backgroundView!)
            make.top.equalTo(self.backgroundView!).offset(15)
        }
        
        self.dayLabel = UILabel()
        self.dayLabel?.text = "9"
        self.dayLabel?.textColor = XZSwiftColor.white
        self.dayLabel?.font = XZClient.XZFont(size: 60)
        self.backgroundView?.addSubview(self.dayLabel!)
        self.dayLabel?.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.backgroundView!).offset(-5)
            make.top.equalTo((self.titleLabel?.snp.bottom)!).offset(20)
        }
        
        let unitLabel = UILabel()
        unitLabel.text = "天"
        unitLabel.textColor = XZSwiftColor.white
        unitLabel.font = XZClient.XZFont(size: 14)
        self.backgroundView?.addSubview(unitLabel)
        unitLabel.snp.makeConstraints { (make) in
            make.left.equalTo((self.dayLabel?.snp.right)!).offset(6)
            make.bottom.equalTo(self.dayLabel!).offset(-6)
        }
        
        let summeryLabel = UILabel()
        summeryLabel.text = "*注: 距离还款日还有1天时会有提醒"
        summeryLabel.textColor = XZSwiftColor.white
        summeryLabel.font = XZClient.XZFont(size: 14)
        self.backgroundView?.addSubview(summeryLabel)
        summeryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.backgroundView!).offset(15)
            make.bottom.equalTo(self.backgroundView!).offset(-10)
        }
    }
}

