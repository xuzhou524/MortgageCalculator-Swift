//
//  UserViewController.swift
//  QiuQiu
//
//  Created by xuzhou on 2021/4/12.
//

import UIKit

class UserViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var isHaveBuy = false
    
    var tableView: UITableView = {
        let tableView = UITableView();
        tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        tableView.separatorStyle = .none
        
        regClass(tableView, cell: LeftTitleTableViewCell.self)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "更多"
        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView);
        self.tableView.snp.makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(named: "color_theme")
        return bgView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = getCell(tableView, cell: LeftTitleTableViewCell.self, indexPath: indexPath)
            cell.nodeNameLabel.text = ["屏蔽广告","分享给贷友"][indexPath.row]
            let names = ["ic_setting","ic_share"]
            cell.nodeImageView.image = UIImage(named: names[indexPath.row])?.withRenderingMode(.alwaysTemplate)
            cell.isHiddenRightImage(hidden: false)
            cell.summeryLabel.isHidden = true
            if (indexPath.row == 0){
                cell.panel.addRoundedCorners(corners: [.topLeft,.topRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: XZClient.ScreenWidth() - 30, height: 64))
            }else if (indexPath.row == 1){
                cell.panel.addRoundedCorners(corners: [.bottomLeft,.bottomRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: XZClient.ScreenWidth() - 30, height: 64))
            }else{
                cell.panel.layer.mask = nil
            }
            return cell
        }else{
            let cell = getCell(tableView, cell: LeftTitleTableViewCell.self, indexPath: indexPath)
            cell.nodeNameLabel.text = ["给个赞","吐个糟","隐私协议","版本号"][indexPath.row]
            let names = ["ic_givePraise","ic_help","ic_privacy","ic_settings_input_svideo"]
            cell.nodeImageView.image = UIImage(named: names[indexPath.row])?.withRenderingMode(.alwaysTemplate)
            if indexPath.row == 0 {
                cell.panel.addRoundedCorners(corners: [.topLeft,.topRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: XZClient.ScreenWidth() - 30, height: 64))
            }else if (indexPath.row == 3){
                cell.panel.addRoundedCorners(corners: [.bottomLeft,.bottomRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: XZClient.ScreenWidth() - 30, height: 64))
            }else{
                cell.panel.layer.mask = nil
            }
            if indexPath.row == 3 {
                cell.isHiddenRightImage(hidden: true)
                let infoDict = Bundle.main.infoDictionary
                if let info = infoDict {
                   // app版本
                   let appVersion = info["CFBundleShortVersionString"] as! String?
                   cell.summeryLabel.text = "v" + appVersion!
                   cell.summeryLabel.isHidden = false
                }
            }else{
                cell.isHiddenRightImage(hidden: false)
                cell.summeryLabel.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}
