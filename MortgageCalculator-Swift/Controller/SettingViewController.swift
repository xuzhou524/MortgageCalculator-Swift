//
//  SettingViewController.swift
//  YuanCommunityV2ex
//
//  Created by gozap on 2020/7/27.
//  Copyright © 2020 com.xuzhou. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate {
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.estimatedRowHeight = 50
        tableView.separatorStyle = .none
        
        regClass(tableView, cell: TitleSwitchTableViewCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        self.view.addSubview(self.tableView);
        self.tableView.snp.makeConstraints{ (make) -> Void in
            make.top.left.right.bottom.equalTo(self.view);
        }
        self.tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 0
        }
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCell(tableView, cell: TitleSwitchTableViewCell.self, indexPath: indexPath)
        cell.titleLabel.text = "屏蔽广告"

        if let switchOn = UserDefaults.standard.object(forKey: "com.xuzhou.advertising") {
            cell.sevenSwitch.setOn(((switchOn as! Int)  == 1) ? true : false , animated: true)
        }else{
            cell.sevenSwitch.setOn(false , animated: true)
        }
        
        cell.sevenSwitch.addTarget(self, action: #selector(didSevenSwitch), for: .touchUpInside)
        
        return cell
    }
    
    @objc func  didSevenSwitch() {
        let switchOn = UserDefaults.standard.object(forKey: "com.xuzhou.advertising")
        if (switchOn != nil && (switchOn as! Int)  == 1) {
            UserDefaults.standard.set(0, forKey: "com.xuzhou.advertising")
        }else{
            UserDefaults.standard.set(1, forKey: "com.xuzhou.advertising")
        }
    }
}
