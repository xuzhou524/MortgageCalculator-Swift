//
//  RootViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/7/31.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import SnapKit

class RootViewController: UIViewController {
    
    var rootSegmentedVC : UISegmentedControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        self.view.backgroundColor = UIColor.white;
        self.navigationController?.navigationBar.isTranslucent = false;

        self.rootSegmentedVC = UISegmentedControl(items: ["我的","你的","他的"])
        self.view.addSubview(self.rootSegmentedVC!)
        self.rootSegmentedVC?.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(10)
            make.height.equalTo(35)
            make.width.equalTo(300)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
