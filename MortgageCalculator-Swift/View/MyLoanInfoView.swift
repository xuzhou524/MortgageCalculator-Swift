//
//  MyLoanInfoView.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2021/5/26.
//  Copyright © 2021 com.longdai. All rights reserved.
//

import UIKit

class MyLoanInfoView: UIView {
    
    let bgImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "ic_MyLoanBg")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let amountTLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 13)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "下次月供"
        return label
    }()
    let conformTLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 18)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "¥"
        return label
    }()
    let amountLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 26)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "3528.43"
        return label
    }()
    
    let dayTLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 13)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "天后"
        return label
    }()
    let dayLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 38)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "23"
        return label
    }()
    
    let timeLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 13)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "2021年06月15日"
        return label
    }()
    
    let summeryLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 13)
        label.textColor = XZSwiftColor.convenientBackgroundColor
        label.text = "*注: 还款日前1天有提醒"
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        sebViews()
    }
    
    func sebViews() {
        
        self.addSubview(bgImageView)

        bgImageView.addSubview(amountLabel)
        bgImageView.addSubview(conformTLabel)
        bgImageView.addSubview(amountTLabel)
        bgImageView.addSubview(dayTLabel)
        bgImageView.addSubview(dayLabel)
        bgImageView.addSubview(timeLabel)
        bgImageView.addSubview(summeryLabel)

        bgImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-10)
        }
        conformTLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview().offset(-10)
        }
        amountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(conformTLabel.snp.right).offset(2)
            make.bottom.equalTo(conformTLabel).offset(1)
        }
        amountTLabel.snp.makeConstraints { (make) in
            make.left.equalTo(conformTLabel)
            make.bottom.equalTo(amountLabel.snp.top).offset(-6)
        }
        
        
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(amountLabel).offset(15)
        }
        
        dayTLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(timeLabel.snp.top).offset(-10)
        }
        dayLabel.snp.makeConstraints { (make) in
            make.right.equalTo(dayTLabel.snp.left).offset(-5)
            make.bottom.equalTo(dayTLabel).offset(3)
        }

        summeryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(amountTLabel)
            make.bottom.equalToSuperview().offset(-20)
        }

    }

}
