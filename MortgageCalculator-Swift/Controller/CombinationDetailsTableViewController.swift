//
//  CombinationDetailsTableViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/16.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class CombinationDetailsTableViewController: UITableViewController {
    
    var accumulationAmontStr:String?
    var accumulationRateStr:String?
    
    var businessAmontStr:String?
    var businessRateStr:String?
    
    var loanNumberStr : String?
    
    var loanTypeInt : NSInteger?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "结算结果"
        self.tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.tableView.separatorStyle = .none
        
        regClass(self.tableView, cell: LoanDetails_TitleTableViewCell.self)
        regClass(self.tableView, cell: LoanDetails_DescribesTableViewCell.self)
        regClass(self.tableView, cell: LoanDetails_CumulativeTableViewCell.self)
        regClass(self.tableView, cell: LoanDetailsTableViewCell.self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        return Int.init(self.loanNumberStr!)! * 12
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                return 60
            case 1:
                return 130
            case 2:
                return 80
            default: break
            }
        }else{
            return 45
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.clipsToBounds = true
        headView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        let loandTitleView = LoanDetailsTitleTableView()
        headView.addSubview(loandTitleView)
        loandTitleView.snp.makeConstraints { (make) in
            make.center.equalTo(headView)
            make.width.equalTo(XZClient.ScreenWidth())
            make.height.equalTo(40)
        }
        return headView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let cell = getCell(tableView, cell: LoanDetails_TitleTableViewCell.self, indexPath: indexPath)
                cell.binds(accumulationAmontStr: self.accumulationAmontStr!, accumulationRateStr: self.accumulationRateStr!, businessAmontStr: self.businessAmontStr!, businessRateStr: self.businessRateStr!, loanNumberStr: self.loanNumberStr!, loanTypeInt: self.loanTypeInt!)
                return cell
            case 1:
                let cell = getCell(tableView, cell: LoanDetails_DescribesTableViewCell.self, indexPath: indexPath)
                cell.bind(businessAmountStr: self.businessAmontStr!, businessRateStr: self.businessRateStr!, accumulationAmountStr: self.accumulationAmontStr!, accumulationRateStr: self.accumulationRateStr!, loanNumberStr: self.loanNumberStr!)
                return cell
            case 2:
                let cell = getCell(tableView, cell: LoanDetails_CumulativeTableViewCell.self, indexPath: indexPath)
                cell.binds(businessAmountStr: self.businessAmontStr!, businessRateStr: self.businessRateStr!, accumulationAmountStr: self.accumulationAmontStr!, accumulationRateStr: self.accumulationRateStr!, loanNumberStr: self.loanNumberStr!, loanTypeInt: self.loanTypeInt!)
                return cell
            default: break
            }
        }else{
            let cell = getCell(tableView, cell: LoanDetailsTableViewCell.self, indexPath: indexPath)
            cell.binds(periodStr:String.init(format: "%d",indexPath.row + 1), accumulationAmontStr: self.accumulationAmontStr!, accumulationRateStr: self.accumulationRateStr!,businessAmontStr: self.businessAmontStr!, businessRateStr: self.businessRateStr!, loanNumberStr: self.loanNumberStr!, loanTypeInt: self.loanTypeInt!)
            return cell
        }
        return UITableViewCell()
    }
}
