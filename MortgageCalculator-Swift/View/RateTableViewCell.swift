//
//  RateTableViewCell.swift
//  MortgageCalculator-Swift
//
//  Created by HuaLaLa on 2021/9/22.
//  Copyright © 2021 com.longdai. All rights reserved.
//

import UIKit

class RateTableViewCell: UITableViewCell {
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 15)
        label.textAlignment = .center
        return label
    }()
    
    var rateOneLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 15)
        label.textAlignment = .center
        return label
    }()
    
    var rateTwoLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 15)
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor;
        
        self.timeLabel.text = "2020-05-21"
        self.contentView.addSubview(self.timeLabel);
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.bottom.equalToSuperview()
            make.width.equalTo((XZClient.ScreenWidth()-30) / 3.00)
        }
        
        self.rateOneLabel.text = "3.45"
        self.contentView.addSubview(self.rateOneLabel);
        self.rateOneLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.bottom.equalToSuperview()
            make.width.equalTo((XZClient.ScreenWidth()-30) / 3.00)
        }
        
        self.rateTwoLabel.text = "4.56"
        self.contentView.addSubview(self.rateTwoLabel);
        self.rateTwoLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.top.bottom.equalToSuperview()
            make.width.equalTo((XZClient.ScreenWidth()-30) / 3.00)
        }
        
        
    }

}
