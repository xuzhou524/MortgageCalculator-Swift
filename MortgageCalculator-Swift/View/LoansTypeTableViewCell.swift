//
//  LoansTypeTableViewCell.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/1.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class LoansTypeTableViewCell: UITableViewCell {

    var titleLabel: UILabel?
    var typeSegmented : UISegmentedControl?
    var bottomSepView : UIImageView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView() ->Void{
        self.selectionStyle = .none
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.titleLabel = UILabel()
        self.titleLabel?.text = "还款方式";
        self.titleLabel?.font = XZClient.XZFont2(size: 15)
        self.contentView.addSubview(self.titleLabel!)
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(15)
        })
        
        self.typeSegmented = UISegmentedControl(items: ["等额本息","等额本金"])
        self.typeSegmented?.tintColor = XZSwiftColor.xzGlay50
        self.typeSegmented?.selectedSegmentIndex = 0
        self.typeSegmented?.setTitleTextAttributes([NSAttributedString.Key.font:XZClient.XZFont2(size: 14)], for: .normal)
        self.contentView.addSubview(self.typeSegmented!)
        self.typeSegmented?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-15)
            make.left.equalTo(self.contentView.snp.centerX).offset(20);
            make.height.equalTo(32);
        })

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
