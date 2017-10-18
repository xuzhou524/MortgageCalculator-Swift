//
//  HousingMarketListViewController.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/15.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import TMCache

class HousingMarketListViewController: ASViewController<ASTableNode> , ASTableDataSource, ASTableDelegate{
    var source: [Newslist] = []
    var housingMarketListItem : RootClass?
    var refreshControl:ZJRefreshControl!
    
    var tempPage : NSInteger!
    var page : NSInteger!
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
        //node.leadingScreensForBatching = 5
        self.page = 0

        self.asyncRequestData()
        
        refreshControl = ZJRefreshControl(scrollView: node.view,refreshBlock: {
            self.dropViewDidBeginRefreshing();
        },loadmoreBlock: {
            self.dropViewDidBeginLoadmore();
        });
    }
    private var indexPathesToBeReloaded: [IndexPath] = []
    //下拉刷新调用的方法
    func asyncRequestData()->Void{
        self.tempPage = 1
        _ = HousingMarketApi.provider.request(.housingMarketList()).filterHttpError().mapResponseToObj(RootClass.self)
            .subscribe(onNext: { (response) in
                
                self.housingMarketListItem = response
                
                if let idsArray = response.idlist?.first?.ids {
                    TMCache.shared().setObject(idsArray as NSCoding, forKey: "liebiao")
                }
                
                let idListArray = response.idlist
                self.source = (idListArray?.first?.newslist)!
                
//                for i in 0...19 {
//                    let indexPath = IndexPath(row:i, section: 0)
//                    self.indexPathesToBeReloaded.append(indexPath)
//                }
//                self.node.reloadRows(at: self.indexPathesToBeReloaded, with: .none)
                self.node.reloadData()
                self.refreshControl.endRefreshing();
                
            }, onError: { (error) in
                print(error.rawString())
                self.refreshControl.endRefreshing();
            })
    }
    
    //下拉刷新调用的方法
    func dropViewDidBeginRefreshing()->Void{
        self.asyncRequestData()
    }
    
    //上拉加载更多调用的方法
    func dropViewDidBeginLoadmore()->Void{
        let idsArray = TMCache.shared().object(forKey: "liebiao") as! NSArray
        
        self.page = self.tempPage
        
        var ids = ""
        let length = idsArray.count
        
        var maxIndex = 0
        
        if (self.page * 20 + 19) > length{
            maxIndex = length
        }else{
            maxIndex = self.page * 20 + 19
        }
        
        for i in self.page * 20 ..< maxIndex{
            let idsModel = idsArray[i] as! Id
            if ids.Lenght > 1{
               ids = ids + "," + idsModel.id!
            }else{
                ids = idsModel.id!
            }
        }
        _ = HousingMarketApi.provider.request(.housingMarketListNext(ids: ids)).filterHttpError().mapResponseToObjArray(Newslist.self, dataPath: ["newslist"])
            .subscribe(onNext: { (response) in
                self.tempPage =  self.tempPage + 1
                let idListArray = response
                let length = idListArray.count
                for i in 0 ..< length{
                    self.source.append(idListArray[i])
                }
//                let indexPathArray = NSMutableArray.init()
//                for i in self.source.count - length...self.source.count - length  {
//                    let indexPath = IndexPath(row:i, section: 0)
//                    indexPathArray.add(indexPath)
//                }
//                self.node.performBatch(animated: false, updates: {
//                    self.node.insertRows(at: indexPathArray as! [IndexPath], with: .none)
//                }, completion: nil)
                self.node.reloadData()
         
                self.refreshControl.endLoadingmore();
            }, onError: { (error) in
                print(error.rawString())
                self.refreshControl.endLoadingmore();
            })
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if self.source.count > 0 {
            return self.source.count
        }
        return 0
    }
    
    func tableView(_ tableView: ASTableView, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = { () -> ASCellNode in
            let cell = HousMarketListTableViewCell(digItem: self.source[indexPath.row])
            return cell
        }
        return cellNodeBlock;
    }

    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        let newListModel = self.source[indexPath.row]
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
