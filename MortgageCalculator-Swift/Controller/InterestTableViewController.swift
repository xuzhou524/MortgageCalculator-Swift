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
        self.view.backgroundColor = XZSwiftColor.white
        
        let shangyeImageView = UIImageView()
        shangyeImageView.image = UIImage.init(named: "shangye")
        view.addSubview(shangyeImageView)
        shangyeImageView.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(XZClient.ScreenWidth() - 20)
            make.height.equalTo((XZClient.ScreenWidth() - 20) / 3)
        })
        
        let gongjijinImageView = UIImageView()
        gongjijinImageView.image = UIImage.init(named: "gongjijin")
        view.addSubview(gongjijinImageView)
        gongjijinImageView.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(shangyeImageView.snp_bottom).offset(15)
            make.width.equalTo(228 * 1.3)
            make.height.equalTo(193 * 1.3)
        })
        
    }

}
