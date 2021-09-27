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
        tableView.backgroundColor = XZSwiftColor.white
        tableView.separatorStyle = .none
        
        regClass(tableView, cell: RateTableViewCell.self)
        regClass(tableView, cell: RateInstructionTableViewCell.self)
        regClass(tableView, cell: RateOldTableViewCell.self)
        
        return tableView
    }()
    
    let lprList = [["公布日期","一年期LPR","五年期LPR"],
                ["2021-09-22","3.85%","4.65%"],
                ["2021-08-20","3.85%","4.65%"],
                ["2021-07-20","3.85%","4.65%"],
                ["2021-06-21","3.85%","4.65%"],
                ["2021-05-20","3.85%","4.65%"],
                ["2021-04-20","3.85%","4.65%"]]
    
    let rateList = [["类型","一至五年(含五年)","五年以上"],
                ["商业贷款","4.75%","4.90%"],
                ["公积金贷款","2.75%","3.25%"]]
    
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return lprList.count
        }else if section == 2 {
            return 1
        }else if section == 3 {
            return rateList.count
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let str = "2019年10月28日，人民银行发布公告，要求自2020年1月1日起，各金融机构不得签订参考贷款基准利率定价的浮动利率贷款合同。自2020年3月1日起，金融机构应与存量浮动利率贷款客户就定价基准转换条款进行协商，把原合同约定的利率定价方式转换为以LPR为定价基准加点形成（加点可为负值），加点数值在合同剩余期限内固定不变；也可转换为固定利率。"
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 8
            paragraphStyle.firstLineHeadIndent = 30.0
            let attrStr = NSMutableAttributedString(string: str, attributes: [.paragraphStyle:paragraphStyle])
            
            let h = attrStr.boundingRect(with: CGSize(width: XZClient.ScreenWidth() - 30, height: 0), options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil).size
                        
            return h.height + 45.0 + 80.0 + 10.0
        }else if indexPath.section == 2 {
            return 54
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = getCell(tableView, cell: RateInstructionTableViewCell.self, indexPath: indexPath)
            return cell
        }else if indexPath.section == 1 {
            let cell = getCell(tableView, cell: RateTableViewCell.self, indexPath: indexPath)
            cell.timeLabel.text = lprList[indexPath.row][0]
            cell.rateOneLabel.text = lprList[indexPath.row][1]
            cell.rateTwoLabel.text = lprList[indexPath.row][2]
            return cell
        }else if indexPath.section == 2 {
            let cell = getCell(tableView, cell: RateOldTableViewCell.self, indexPath: indexPath)
            return cell
        }else if indexPath.section == 3 {
            let cell = getCell(tableView, cell: RateTableViewCell.self, indexPath: indexPath)
            cell.timeLabel.text = rateList[indexPath.row][0]
            cell.rateOneLabel.text = rateList[indexPath.row][1]
            cell.rateTwoLabel.text = rateList[indexPath.row][2]
            return cell
        }
        return UITableViewCell()
        
    }
}
