//
//  FriendshipRecommenViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/11.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class FriendshipRecommenViewController: UITableViewController {

    let iconArray = ["longdai","onePai","fangdai","fangdai","fangdai","tianqi"]
    let appUrlArray = ["","","","",""]
    
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
}
