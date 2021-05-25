//
//  MoreViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/7/31.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import StoreKit

class MoreViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "更多"
        self.tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.tableView.separatorStyle = .none
        
        regClass(self.tableView, cell: MoreTableViewCell.self)
        regClass(self.tableView, cell: More_InterTableViewCell.self)
        regClass(self.tableView, cell: titleTableViewCell.self)
        
        let rightButton = UIButton.init(frame:CGRect(x:0, y:0, width:42, height:42))
        rightButton.setTitle("设置", for: .normal)
        rightButton.setTitleColor(XZSwiftColor.xzGlay50, for: .normal)
        rightButton.addTarget(self,action:#selector(rightTapPed),for:.touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    @objc func rightTapPed() {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
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
        let activityController = UIActivityViewController(activityItems: ["https://apps.apple.com/cn/app/id1272033544" + " (分享来自@房贷计算器) " ], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityController, animated: true, completion: nil)
    }
    
    @objc func zanImageViewTap(){
        let  urlString = "itms-apps://itunes.apple.com/app/id1272033544?action=write-review"
        UIApplication.shared.open(URL.init(string: urlString)!, options: [:], completionHandler: nil)
    }
    @objc func tuImageView(){
        UIApplication.shared.open(URL(string:"mqq://im/chat?chat_type=wpa&uin=1043037904&version=1&src_type=web")!, options: [:], completionHandler: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
