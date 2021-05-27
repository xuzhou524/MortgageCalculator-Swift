//
//  InterestTableViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2019/9/24.
//  Copyright © 2019 com.longdai. All rights reserved.
//

import UIKit

class InterestTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "基准利率表"
        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        let label = UILabel()
        label.text = "中国人民银行2015年10月24日基准利率表"
        label.font = XZClient.XZFont(size: 15)
        label.textColor = XZSwiftColor.xzGlay50
        view.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(15)
        })
        
        let shangyeImageView = UIImageView()
        shangyeImageView.image = UIImage.init(named: "shangye")
        view.addSubview(shangyeImageView)
        shangyeImageView.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(label.snp_bottom).offset(15)
            make.width.equalTo(275 * 1.2)
            make.height.equalTo(140 * 1.2)
        })
        
        let gongjijinImageView = UIImageView()
        gongjijinImageView.image = UIImage.init(named: "gongjijin")
        view.addSubview(gongjijinImageView)
        gongjijinImageView.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(shangyeImageView.snp_bottom).offset(15)
            make.width.equalTo(275 * 1.2)
            make.height.equalTo(140 * 1.2)
        })
        
    }

}
