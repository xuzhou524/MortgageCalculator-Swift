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
    var commerciaiLoansVC : CommercialLoansTableViewController?
    var combinationLoansVC : CombinationLoabsTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "房贷计算器"
        self.view.backgroundColor = UIColor.white;
        self.navigationController?.navigationBar.isTranslucent = false;

        self.rootSegmentedVC = UISegmentedControl(items: ["商业贷款","公积金贷款","组合贷款"])
        self.rootSegmentedVC?.tintColor = UIColor.black
        self.rootSegmentedVC?.setTitleTextAttributes([NSFontAttributeName:XZClient.XZFont2(size: 15)], for: .normal)
        self.view.addSubview(self.rootSegmentedVC!)
        self.rootSegmentedVC?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(10)
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
            make.height.equalTo(35)
        })
        
        self.rootSegmentedVC?.selectedSegmentIndex = 0;
        self.rootSegmentedVC?.addTarget(self, action: #selector(RootViewController.segmentDidchange), for: .valueChanged)
        
        self.segmentDidchange(segmented: self.rootSegmentedVC!)
    }
    
    func segmentDidchange(segmented:UISegmentedControl){
        if segmented.selectedSegmentIndex == 0 || segmented.selectedSegmentIndex == 1{
            if ((self.commerciaiLoansVC) == nil) {
                self.commerciaiLoansVC = CommercialLoansTableViewController()
                self.commerciaiLoansVC?.rootNavigationController = self.navigationController as? XZSwiftNavigationController
                self.view.addSubview((self.commerciaiLoansVC?.view)!)
                self.commerciaiLoansVC?.view.snp.makeConstraints({ (make) in
                    make.left.right.bottom.equalTo(self.view)
                    make.top.equalTo(self.view).offset(65)
                })
            }
            self.view.addSubview((self.commerciaiLoansVC?.view)!)
        }else{
            if ((self.combinationLoansVC) == nil) {
                self.combinationLoansVC = CombinationLoabsTableViewController()
                self.view.addSubview((self.combinationLoansVC?.view)!)
                self.combinationLoansVC?.view.snp.makeConstraints({ (make) in
                    make.left.right.bottom.equalTo(self.view)
                    make.top.equalTo(self.view).offset(65)
                })
            }
            self.view.addSubview((self.combinationLoansVC?.view)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
