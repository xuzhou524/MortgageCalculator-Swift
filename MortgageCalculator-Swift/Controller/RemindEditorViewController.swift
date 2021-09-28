//
//  RemindEditorViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/21.
//  Copyright © 2017年 xuzhou. All rights reserved.
//

import UIKit
import AdKleinSDK

class RemindEditorViewController: UIViewController {
    var rootSegmentedVC : UISegmentedControl?
    var commerciaiLoansVC : RemindCommercialViewController?
    var accumulationLoansVC : RemindAccumulationViewController?
    var combinationLoansVC : RemindCombinationViewController?
    
    var bannerView:AdKleinSDKBannerAdView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "添加"
        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.navigationController?.navigationBar.isTranslucent = false;
        
        //展示广告
        showBannerView()
        
        self.rootSegmentedVC = UISegmentedControl(items: ["商业贷款","公积金贷款","组合贷款"])
        self.rootSegmentedVC?.tintColor = XZSwiftColor.xzGlay50
        self.rootSegmentedVC?.setTitleTextAttributes([NSAttributedString.Key.font:XZClient.XZFont2(size: 15)], for: .normal)
        self.view.addSubview(self.rootSegmentedVC!)
        self.rootSegmentedVC?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(15)
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
            make.height.equalTo(40)
        })
        
        self.rootSegmentedVC?.selectedSegmentIndex = 0;
        self.rootSegmentedVC?.addTarget(self, action: #selector(RemindEditorViewController.segmentDidchange), for: .valueChanged)
        
        self.segmentDidchange(segmented: self.rootSegmentedVC!)
    }
    
    @objc func segmentDidchange(segmented:UISegmentedControl){
        if segmented.selectedSegmentIndex == 0 {
            if ((self.commerciaiLoansVC) == nil) {
                self.commerciaiLoansVC = RemindCommercialViewController()
                self.view.addSubview((self.commerciaiLoansVC?.view)!)
                self.commerciaiLoansVC?.rootNavigationController = self.navigationController as? XZSwiftNavigationController
                self.commerciaiLoansVC?.view.snp.makeConstraints({ (make) in
                    make.left.right.bottom.equalTo(self.view)
                    make.top.equalTo((self.rootSegmentedVC?.snp.bottom)!).offset(15)
                })
            }
            self.view.addSubview((self.commerciaiLoansVC?.view)!)
            self.view.bringSubviewToFront(bannerView!)
        }else if  segmented.selectedSegmentIndex == 1 {
            if ((self.accumulationLoansVC) == nil) {
                self.accumulationLoansVC = RemindAccumulationViewController()
                self.view.addSubview((self.accumulationLoansVC?.view)!)
                self.accumulationLoansVC?.rootNavigationController = self.navigationController as? XZSwiftNavigationController
                self.accumulationLoansVC?.view.snp.makeConstraints({ (make) in
                    make.left.right.bottom.equalTo(self.view)
                    make.top.equalTo((self.rootSegmentedVC?.snp.bottom)!).offset(15)
                })
            }
            self.view.addSubview((self.accumulationLoansVC?.view)!)
            self.view.bringSubviewToFront(bannerView!)
        }else{
            if ((self.combinationLoansVC) == nil) {
                self.combinationLoansVC = RemindCombinationViewController()
                self.view.addSubview((self.combinationLoansVC?.view)!)
                self.combinationLoansVC?.rootNavigationController = self.navigationController as? XZSwiftNavigationController
                self.combinationLoansVC?.view.snp.makeConstraints({ (make) in
                    make.left.right.equalTo(self.view)
                    make.top.equalTo((self.rootSegmentedVC?.snp.bottom)!).offset(15)
                    make.bottom.equalTo(self.view).offset(-64)
                })
            }
            self.view.addSubview((self.combinationLoansVC?.view)!)
            self.view.bringSubviewToFront(bannerView!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
}


extension RemindEditorViewController:AdKleinSDKBannerAdViewDelegate {
    func showBannerView() {
        self.bannerView = AdKleinSDKBannerAdView.init(placementId: CONST_BANNER_ID, viewController: self)
        let h = (XZClient.ScreenWidth() - 20) / 6.4 + 10
        self.bannerView?.frame = CGRect(x: 10, y: XZClient.ScreenHeight() - h - (XZClient.XZiPhoneX() ? 100 : 64), width: XZClient.ScreenWidth() - 20, height: h)
        self.bannerView?.animated = true
        self.bannerView?.autoSwitchInterval = 60
        self.bannerView?.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.view.addSubview(self.bannerView!)
        self.bannerView?.load()
    }
    
}
