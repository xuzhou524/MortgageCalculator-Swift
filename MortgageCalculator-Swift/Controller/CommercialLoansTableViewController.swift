//
//  CommercialLoansTableViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/1.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class CommercialLoansTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        regClass(self.tableView, cell: BaseTableViewCell.self)
        regClass(self.tableView, cell: LoansTypeTableViewCell.self)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 3 {
            
            let cell = getCell(tableView, cell: LoansTypeTableViewCell.self, indexPath: indexPath)
            return cell
        }
        
        let cell = getCell(tableView, cell: BaseTableViewCell.self, indexPath: indexPath)
        
        if indexPath.row == 0 {
            cell.titleLabel?.text = "贷款金额（万元）"
            cell.topSepView?.isHidden = false
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
        }else if indexPath.row == 1 {
            cell.titleLabel?.text = "贷款年限（年）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
        }else if indexPath.row == 2 {
            cell.titleLabel?.text = "贷款利率（%）"
            cell.topSepView?.isHidden = true
            cell.bottomSepView?.isHidden = true
            cell.bottomShortSepView?.isHidden = false
        }
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
