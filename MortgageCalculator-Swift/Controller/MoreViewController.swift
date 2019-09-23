//
//  MoreViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/7/31.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import StoreKit
import GoogleMobileAds

class MoreViewController: UITableViewController {
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "更多"
        self.tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.tableView.separatorStyle = .none
        
        bannerView = GADBannerView.init(frame: CGRect(x: 0,  y: XZClient.ScreenHeight() - 230, width: XZClient.ScreenWidth(), height: 50))
        bannerView.backgroundColor = UIColor.orange
        self.tableView.addSubview(bannerView)
        bannerView.adUnitID = "ca-app-pub-9353975206269682/4586207572"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        regClass(self.tableView, cell: MoreTableViewCell.self)
        regClass(self.tableView, cell: More_InterTableViewCell.self)
        regClass(self.tableView, cell: titleTableViewCell.self)
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).row == 0 {
            return 170
        }
        if (indexPath as NSIndexPath).row == 1{
            return 80
        }
        if (indexPath as NSIndexPath).row == 2{
            return 15
        }
        if (indexPath as NSIndexPath).row == 5{
            return 0
        }
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let moreCell = getCell(tableView, cell: MoreTableViewCell.self, indexPath: indexPath)
            moreCell.selectionStyle = .none
            return moreCell
        }
        if indexPath.row == 1{
            let interCell = getCell(tableView, cell: More_InterTableViewCell.self, indexPath: indexPath)
            interCell.zanImageView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(MoreViewController.zanImageViewTap)))
            interCell.tuImageView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(MoreViewController.tuImageView)))
            interCell.selectionStyle = .none
            return interCell
        }
        
        if indexPath.row == 2{
            let cell = UITableViewCell()
            cell.backgroundColor = XZSwiftColor.convenientBackgroundColor
            cell.selectionStyle = .none
            return cell
        }
        let baseCell = getCell(tableView, cell: titleTableViewCell.self, indexPath: indexPath)
        baseCell.clipsToBounds = true
        baseCell.selectionStyle = .none
        baseCell.iconImageView?.isHidden = false
        if (indexPath as NSIndexPath).row == 3 {
            baseCell.titleLabel?.text = "新浪微博"
            baseCell.detaileLabel?.text = "徐_Aaron"
        }else if (indexPath as NSIndexPath).row == 4 {
            baseCell.titleLabel?.text = "推荐给贷友"
            baseCell.detaileLabel?.text = ""
        }else if (indexPath as NSIndexPath).row == 5 {
            baseCell.titleLabel?.text = "为你发现"
            baseCell.detaileLabel?.text = ""
        }else if (indexPath as NSIndexPath).row == 6 {
            let infoDict = Bundle.main.infoDictionary
            if let info = infoDict {
                // app版本
                let appVersion = info["CFBundleShortVersionString"] as! String?
                baseCell.detaileLabel?.text = "v" + appVersion!
                baseCell.iconImageView?.isHidden = true
            }
        }
        return baseCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
           self.share()
        }else if indexPath.row == 5 {
            let friendVC = FriendshipRecommenViewController()
            friendVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(friendVC, animated: true);
        }
    }
    
    func share()  {
        // 1.创建分享参数
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: "想容易，就用易房贷 - 最专业的贷款计算神器" + "  http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1272033544&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",
                                          images : UIImage(named: "Icon-60"),
                                          url : NSURL(string:"http://www.xzzai.com") as URL?,
                                          title : "用易房贷",
                                          type : SSDKContentType.auto)
        
        SSUIShareActionSheetStyle.setShareActionSheetStyle(.simple)
        //2.进行分享
        _ = ShareSDK.showShareActionSheet(nil, items: nil, shareParams: shareParames) { (state : SSDKResponseState, platformType : SSDKPlatformType, userdata : [AnyHashable : Any]?, contentEnity : SSDKContentEntity?, error : Error?, end) in
            
            switch state{
                
            case SSDKResponseState.success: print("分享成功")
            case SSDKResponseState.fail:    print("分享失败,错误描述:\(String(describing: error))")
            case SSDKResponseState.cancel:  print("分享取消")
                
            default:
                break
            }
        }
    }
    
    @objc func zanImageViewTap(){
        if #available(iOS 10.3, *) {
            #if DEBUG
            #else
                SKStoreReviewController.requestReview()
            #endif
        }else if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string:"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1272033544&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8")!, options: [:], completionHandler: nil)
        } else {
            let urlString = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1272033544&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
            let url = NSURL(string: urlString)
            UIApplication.shared.openURL(url! as URL)
        }
    }
    @objc func tuImageView(){
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string:"mqq://im/chat?chat_type=wpa&uin=1043037904&version=1&src_type=web")!, options: [:], completionHandler: nil)
        } else {
            let urlString = "mqq://im/chat?chat_type=wpa&uin=1043037904&version=1&src_type=web"
            let url = NSURL(string: urlString)
            UIApplication.shared.openURL(url! as URL)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
