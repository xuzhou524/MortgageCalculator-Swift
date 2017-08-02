//
//  BottonTableViewCell.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/2.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class BottonTableViewCell: UITableViewCell {

    var calculateButton: UIButton?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView() ->Void{
        self.selectionStyle = .none
        self.calculateButton = UIButton()
        self.calculateButton?.setTitle("计算", for: .normal)
        self.calculateButton?.setTitleColor(UIColor.white, for: .normal)
        self.calculateButton?.titleLabel?.font = XZClient.XZFont(size: 18)
        self.calculateButton?.backgroundColor = UIColor.black
        self.calculateButton?.layer.cornerRadius = 5;
        self.contentView.addSubview(self.calculateButton!)
        self.calculateButton?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
            make.height.equalTo(40)
        })
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
