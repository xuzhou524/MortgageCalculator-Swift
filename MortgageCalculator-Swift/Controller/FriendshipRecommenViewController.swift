//
//  FriendshipRecommenViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/11.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class FriendshipRecommenViewController: UITableViewController {

    let iconArray = ["longdai","v2ex","fangdai","onePai","lanyamao","tianqi"]
    let appUrlArray = ["https://itunes.apple.com/cn/app/id900365369?mt=8",
                       "https://itunes.apple.com/cn/app/id1078157349?mt=8",
                       "https://itunes.apple.com/cn/app/id1272033544?mt=8",
                       "https://itunes.apple.com/cn/app/id1239242152?mt=8",
                       "https://itunes.apple.com/cn/app/id1116575370?mt=8",
                       "https://itunes.apple.com/cn/app/id1107521185?mt=8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "为你发现"
        self.tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.tableView.separatorStyle = .none
        
        regClass(self.tableView, cell: FriendshipTableViewCell.self)

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.iconArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.4 * XZClient.ScreenWidth() + 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friendshipCell = getCell(tableView, cell: FriendshipTableViewCell.self, indexPath: indexPath)
        friendshipCell.selectionStyle = .none
        friendshipCell.iconImageView?.image = UIImage.init(named: self.iconArray[indexPath.row])
        return friendshipCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string:self.appUrlArray[indexPath.row])!, options: [:], completionHandler: nil)
        } else {
            let urlString = self.appUrlArray[indexPath.row]
            let url = NSURL(string: urlString)
            UIApplication.shared.openURL(url! as URL)
        }
    }
    
}
