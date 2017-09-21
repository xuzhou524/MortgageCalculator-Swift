//
//  HousingMarketListViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/15.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HousingMarketListViewController: ASViewController<ASTableNode> , ASTableDataSource, ASTableDelegate{
    
    var housingMarketListItem : RootClass?
    
    convenience init(){
        self.init(node: ASTableNode(style: .plain))
    }
    
    override init(node: ASTableNode) {
        super.init(node: node)
        node.delegate = self
        node.dataSource = self
        node.view.separatorStyle = .none
        node.backgroundColor = XZSwiftColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "楼市"
        
        _ = HousingMarketApi.provider.request(.housingMarketList).filterResponseError().mapResponseToObj(RootClass.self)
            .subscribe(onNext: { (response) in
                self.housingMarketListItem = response
                self.node.reloadData()
   
            }, onError: { (error) in
                print(error.rawString())
            })
        
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        let idListArray = self.housingMarketListItem?.idlist
        let newListArray = idListArray?.first?.newslist
        
        if (newListArray != nil) {
            return (newListArray?.count)!
        }
        return 0
    }
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let idListArray = self.housingMarketListItem?.idlist
        let newListArray = idListArray?.first?.newslist
        return HousMarketListTableViewCell(digItem: newListArray![indexPath.row] )
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        let idListArray = self.housingMarketListItem?.idlist
        let newListArray = idListArray?.first?.newslist
        let newListModel = newListArray![indexPath.row]
        let housMarkVc = HousingMarketDetailViewController()
        housMarkVc.housingMarketDetailUrl = newListModel.url
        housMarkVc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(housMarkVc, animated: true)
        self.node.view.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
