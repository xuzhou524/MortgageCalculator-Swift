//
//  RemindTableViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/2.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import TMCache

class RemindTableViewController: UIViewController {
    
    var remindDayTitleView : RemindDayTitleView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "提醒"
        self.view.backgroundColor = XZSwiftColor.white;
        
        self.remindDayTitleView = RemindDayTitleView()
        self.view.addSubview(self.remindDayTitleView!)
        self.remindDayTitleView?.snp.makeConstraints({ (make) -> Void in
            make.top.left.top.right.equalTo(self.view)
            make.height.equalTo(250)
        });
        
        let rightButton = UIButton.init(frame:CGRect(x:0, y:0, width:28, height:28))
        rightButton.setImage(UIImage(named: "selectbianji"), for: .normal)
        rightButton.setImage(UIImage(named: "bianji"), for: .highlighted)
        rightButton.addTarget(self,action:#selector(RemindTableViewController.rightTapPed),for:.touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let loanModels = TMCache.shared().object(forKey: kTMCacheLoanManage) as! LoanCacheManage
        print("=======%@",loanModels.businessPrincipalStr!)
    }
    
    func rightTapPed(){
        let editorVC = RemindEditorViewController()
        self.navigationController?.pushViewController(editorVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
