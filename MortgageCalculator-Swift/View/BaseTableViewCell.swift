//
//  BaseTableViewCell.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/1.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel?
    var bgTextFieldView : UIView?
    var textField: UITextField?
    
    var topSepView : UIImageView?
    var bottomSepView : UIImageView?
    var bottomShortSepView : UIImageView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    func sebView() ->Void{
        
        self.titleLabel = UILabel()
        self.titleLabel?.text = "贷款金额（万元）";
        self.contentView.addSubview(self.titleLabel!)
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(15)
        })
        
        self.bgTextFieldView = UIView()
        self.bgTextFieldView?.layer.borderWidth = 1
        self.bgTextFieldView?.layer.borderColor = UIColor.black.cgColor
        self.bgTextFieldView?.layer.cornerRadius = 5
        self.contentView.addSubview(self.bgTextFieldView!)
        self.bgTextFieldView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-15)
            make.left.equalTo(self.contentView.snp.centerX).offset(10);
            make.height.equalTo(32);
        })
        
        self.textField = UITextField()
        self.contentView.addSubview(self.textField!)
        self.textField?.snp.makeConstraints({ (make) in
            make.top.bottom.equalTo(self.bgTextFieldView!)
            make.right.equalTo(self.bgTextFieldView!).offset(-8)
            make.left.equalTo(self.bgTextFieldView!).offset(8);
        })
        
        self.topSepView = UIImageView()
        self.topSepView?.backgroundColor = UIColor.black
        self.contentView.addSubview(self.topSepView!)
        self.topSepView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(self.contentView)
            make.height.equalTo(1)
        })
        
        self.bottomSepView = UIImageView()
        self.bottomSepView?.backgroundColor = UIColor.black
        self.contentView.addSubview(self.bottomSepView!)
        self.bottomSepView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(1)
        })
        
        self.bottomShortSepView = UIImageView()
        self.bottomShortSepView?.backgroundColor = UIColor.black
        self.contentView.addSubview(self.bottomShortSepView!)
        self.bottomShortSepView?.snp.makeConstraints({ (make) in
            make.right.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(15)
            make.height.equalTo(1)
        })
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
