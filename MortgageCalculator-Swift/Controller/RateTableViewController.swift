//
//  RateTableViewController.swift
//  MortgageCalculator-Swift
//
//  Created by HuaLaLa on 2021/9/22.
//  Copyright © 2021 com.longdai. All rights reserved.
//

import UIKit

class RateTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView: UITableView = {
        let tableView = UITableView();
        tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        tableView.separatorStyle = .none
        
        regClass(tableView, cell: RateTableViewCell.self)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "房贷利率"
        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView);
        self.tableView.snp.makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = RateTableViewCell()
        bgView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        bgView.timeLabel.text = "发布时间"
        return bgView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCell(tableView, cell: RateTableViewCell.self, indexPath: indexPath)
        return cell
    }
}
