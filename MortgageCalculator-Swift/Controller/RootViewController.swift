//
//  RootViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/7/31.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMobileAds

class RootViewController: UIViewController {
    
    var rootSegmentedVC : UISegmentedControl?
    var commerciaiLoansVC : CommercialLoansTableViewController?
    var accumulationLoansVC : AccumulationFundTableViewController?
    var combinationLoansVC : CombinationLoabsTableViewController?
    var bannerView: GADBannerView!
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "房贷计算器"
        label.font = XZClient.XZFont3(size: 20)
        label.textColor = UIColor.init(named: "ic_theme")
        return label
    }()
    
    let rightBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "ic_More"), for: .normal)
        return btn
    }()
    
    let myLoanInfoView:MyLoanInfoView = {
        let view = MyLoanInfoView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        #if DEBUG
        #else
        bannerView = GADBannerView.init(frame: CGRect(x: 0,  y: XZClient.ScreenHeight() - 180, width: XZClient.ScreenWidth(), height: 50))
        if (XZClient.XZiPhoneX()) {
            bannerView.frame = CGRect(x: 0,  y: XZClient.ScreenHeight() - 230, width: XZClient.ScreenWidth(), height: 50)
        }
        bannerView.adSize = kGADAdSizeBanner
        bannerView.center.x = self.view.center.x
        self.view.addSubview(bannerView)
        self.view.bringSubviewToFront(bannerView)
        bannerView.adUnitID = "ca-app-pub-9353975206269682/6008483340"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        #endif

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        self.view.backgroundColor = UIColor.white;
        self.navigationController?.navigationBar.isTranslucent = false;
        
        self.view.addSubview(myLoanInfoView)
        self.myLoanInfoView.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(150)
        })

        self.rootSegmentedVC = UISegmentedControl(items: ["商业贷款","公积金贷款","组合贷款"])
        self.rootSegmentedVC?.tintColor = XZSwiftColor.xzGlay50
        self.rootSegmentedVC?.setTitleTextAttributes([NSAttributedString.Key.font:XZClient.XZFont2(size: 15)], for: .normal)
        self.view.addSubview(self.rootSegmentedVC!)
        self.rootSegmentedVC?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(155)
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
            make.height.equalTo(40)
        })
        
        self.rootSegmentedVC?.selectedSegmentIndex = 0;
        self.rootSegmentedVC?.addTarget(self, action: #selector(RootViewController.segmentDidchange), for: .valueChanged)
        
        self.segmentDidchange(segmented: self.rootSegmentedVC!)
        
//        let rightButton = UIButton.init(frame:CGRect(x:0, y:0, width:44, height:28))
//        rightButton.setTitle("基准", for: .normal)
//        rightButton.titleLabel?.font = XZClient.XZFont(size: 16)
//        rightButton.setTitleColor(XZSwiftColor.xzGlay50, for: .normal)
//        rightButton.addTarget(self,action:#selector(RootViewController.rightTapPed),for:.touchUpInside)
//        let rightBarButton = UIBarButtonItem(customView: rightButton)
//        self.navigationItem.rightBarButtonItem = rightBarButton
    
    }
    
    @objc func rightTapPed(){
  self.navigationController?.pushViewController(InterestTableViewController(), animated: true)
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
            #if DEBUG
            #else
            self.view.bringSubviewToFront(bannerView)
            #endif
            
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
            #if DEBUG
            #else
            self.view.bringSubviewToFront(bannerView)
            #endif
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
            #if DEBUG
            #else
            self.view.bringSubviewToFront(bannerView)
            #endif
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
