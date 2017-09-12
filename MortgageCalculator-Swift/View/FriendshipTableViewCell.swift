//
//  FriendshipTableViewCell.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/11.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class FriendshipTableViewCell: UITableViewCell {

    var iconImageView : UIImageView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor;
        
        let bgView = UIView()
        bgView.backgroundColor = XZSwiftColor.gray
        bgView.layer.cornerRadius = 3
        bgView.layer.shadowOpacity = 0.8
        bgView.layer.shadowColor = XZSwiftColor.xzGlay129.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bgView.layer.shadowRadius = 3
        self.contentView.addSubview(bgView)
        bgView.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.top.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-15)
            make.bottom.equalTo(self.contentView).offset(-10)
        });
        
        self.iconImageView = UIImageView()
        self.iconImageView?.layer.cornerRadius = 3
        self.iconImageView?.layer.masksToBounds = true
        self.contentView.addSubview(self.iconImageView!)
        self.iconImageView?.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.top.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-15)
            make.bottom.equalTo(self.contentView).offset(-10)
        });
        
    }

}
