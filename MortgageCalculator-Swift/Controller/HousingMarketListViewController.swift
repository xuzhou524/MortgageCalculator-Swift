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
                print(response.idlist)
                
            }, onError: { (error) in
                print("=========" + error.rawString())
            })
        
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return HousMarketListTableViewCell(digItem: "dsds")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
