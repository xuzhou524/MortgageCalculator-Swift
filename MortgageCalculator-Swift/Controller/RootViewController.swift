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
    var accumulationLoansVC : AccumulationFundTableViewController?
    var combinationLoansVC : CombinationLoabsTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Thread.sleep(forTimeInterval: 1.0)
        
        self.navigationItem.title = "房贷计算器"
        self.view.backgroundColor = UIColor.white;
        self.navigationController?.navigationBar.isTranslucent = false;

        self.rootSegmentedVC = UISegmentedControl(items: ["商业贷款","公积金贷款","组合贷款"])
        self.rootSegmentedVC?.tintColor = XZSwiftColor.xzGlay50
        self.rootSegmentedVC?.setTitleTextAttributes([NSAttributedString.Key.font:XZClient.XZFont2(size: 15)], for: .normal)
        self.view.addSubview(self.rootSegmentedVC!)
        self.rootSegmentedVC?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(15)
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
            make.height.equalTo(35)
        })
        
        self.rootSegmentedVC?.selectedSegmentIndex = 0;
        self.rootSegmentedVC?.addTarget(self, action: #selector(RootViewController.segmentDidchange), for: .valueChanged)
        
        self.segmentDidchange(segmented: self.rootSegmentedVC!)
    }
    
    @objc func segmentDidchange(segmented:UISegmentedControl){
        if segmented.selectedSegmentIndex == 0 {
            if ((self.commerciaiLoansVC) == nil) {
                self.commerciaiLoansVC = CommercialLoansTableViewController()
                self.commerciaiLoansVC?.rootNavigationController = self.navigationController as? XZSwiftNavigationController
                self.view.addSubview((self.commerciaiLoansVC?.view)!)
                self.commerciaiLoansVC?.view.snp.makeConstraints({ (make) in
                    make.left.right.bottom.equalTo(self.view)
                    make.top.equalTo((self.rootSegmentedVC?.snp.bottom)!).offset(15)
                })
            }
            self.view.addSubview((self.commerciaiLoansVC?.view)!)
        }else if  segmented.selectedSegmentIndex == 1 {
            if ((self.accumulationLoansVC) == nil) {
                self.accumulationLoansVC = AccumulationFundTableViewController()
                self.accumulationLoansVC?.rootNavigationController = self.navigationController as? XZSwiftNavigationController
                self.view.addSubview((self.accumulationLoansVC?.view)!)
                self.accumulationLoansVC?.view.snp.makeConstraints({ (make) in
                    make.left.right.bottom.equalTo(self.view)
                    make.top.equalTo((self.rootSegmentedVC?.snp.bottom)!).offset(15)
                })
            }
            self.view.addSubview((self.accumulationLoansVC?.view)!)
        }else{
            if ((self.combinationLoansVC) == nil) {
                self.combinationLoansVC = CombinationLoabsTableViewController()
                self.combinationLoansVC?.rootNavigationController = self.navigationController as? XZSwiftNavigationController
                self.view.addSubview((self.combinationLoansVC?.view)!)
                self.combinationLoansVC?.view.snp.makeConstraints({ (make) in
                    make.left.right.bottom.equalTo(self.view)
                    make.top.equalTo((self.rootSegmentedVC?.snp.bottom)!).offset(15)
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
