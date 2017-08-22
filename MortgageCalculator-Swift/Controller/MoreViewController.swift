//
//  MoreViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/7/31.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class MoreViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "更多"
        self.tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.tableView.separatorStyle = .none
        
        regClass(self.tableView, cell: MoreTableViewCell.self)
        regClass(self.tableView, cell: More_InterTableViewCell.self)
        regClass(self.tableView, cell: titleTableViewCell.self)
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
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
        baseCell.selectionStyle = .none
        baseCell.iconImageView?.isHidden = false
        if (indexPath as NSIndexPath).row == 3 {
            baseCell.titleLabel?.text = "新浪微博"
            baseCell.detaileLabel?.text = "徐_Aaron"
        }
        if (indexPath as NSIndexPath).row == 4 {
            baseCell.titleLabel?.text = "推荐给贷友"
            baseCell.detaileLabel?.text = ""
        }
        if (indexPath as NSIndexPath).row == 5 {
            let infoDict = Bundle.main.infoDictionary
            if let info = infoDict {
                // app版本
                let appVersion = info["CFBundleShortVersionString"] as! String!
                baseCell.detaileLabel?.text = "v" + appVersion!
                baseCell.iconImageView?.isHidden = true
            }
        }
        return baseCell
    }

    func zanImageViewTap(){
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string:"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1272033544&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8")!, options: [:], completionHandler: nil)
        } else {
            let urlString = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1272033544&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
            let url = NSURL(string: urlString)
            UIApplication.shared.openURL(url! as URL)
        }
    }
    func tuImageView(){
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
