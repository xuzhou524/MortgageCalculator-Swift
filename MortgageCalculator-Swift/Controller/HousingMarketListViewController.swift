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
import SwiftyJSON
import Moya
import Result
import RxSwift
import GoogleMobileAds

class HousingMarketListViewController: ASViewController<ASTableNode> , ASTableDataSource, ASTableDelegate{
    
    let titleArray : NSMutableArray = ["淘宝","京东","美团","网址导航","百度","秀场","图片","汽车之家"]
    let iamgeArray : NSMutableArray = ["taoBao","jingDong","meiTuan","wangzhi","baiDu","video","tupian","che"]
    let tapUrlArray : NSMutableArray = ["https://m.taobao.com","https://m.jd.com","https://m.meituan.com","http://m.duba.com","https://m.baidu.com","http://m.v.6.cn","http://www.opgirl.cn","http://m.autohome.com.cn"]
    
    var source: [Newslist] = []
    var housingMarketListItem : RootClass?
    var refreshControl:ZJRefreshControl!
    
    var tempPage : NSInteger!
    var page : NSInteger!
    var bannerView: GADBannerView!
    
    override init(node: ASTableNode) {
        super.init(node: ASTableNode(style: .plain))
        node.delegate = self
        node.dataSource = self
        node.view.separatorStyle = .none
        node.backgroundColor = XZSwiftColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(node: ASTableNode(style: .plain))
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "生活"
        
        bannerView = GADBannerView.init(frame: CGRect(x: 0,  y: XZClient.ScreenHeight() - 180, width: XZClient.ScreenWidth(), height: 50))
        if (XZClient.XZiPhoneX()) {
            bannerView.frame = CGRect(x: 0,  y: XZClient.ScreenHeight() - 230, width: XZClient.ScreenWidth(), height: 50)
        }
        bannerView.adSize = kGADAdSizeBanner
        bannerView.center.x = self.view.center.x
        self.view.addSubview(bannerView)
        self.view.bringSubviewToFront(bannerView)
        bannerView.adUnitID = "ca-app-pub-9353975206269682/6008483340"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        self.node.view.separatorStyle = .none;
        self.node.delegate = self
        self.node.dataSource = self
        
        let lifeHeadView = LifeHeadView.init(imageArray: iamgeArray,
                                             titleArray: titleArray)
        lifeHeadView.backgroundColor = XZSwiftColor.white
        node.view.tableHeaderView = lifeHeadView
        
        for i in 0 ..< lifeHeadView.headViewArray.count {
            let headView : LifeView = lifeHeadView.headViewArray[i] as! LifeView
            headView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imgPuls)))
        }
        
        self.page = 0

        self.asyncRequestData()
        refreshControl = ZJRefreshControl(scrollView: node.view,refreshBlock: {
            self.dropViewDidBeginRefreshing();
        },loadmoreBlock: {
            self.dropViewDidBeginLoadmore();
        });
    }
    
    @objc func imgPuls(sender:UITapGestureRecognizer) {
        let webViewVC = UIWebViewController()
        webViewVC.housingMarketDetailUrl = tapUrlArray[(sender.view?.tag)! - 100] as? String
        webViewVC.titleStr = titleArray[(sender.view?.tag)! - 100] as? String
        webViewVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    private var indexPathesToBeReloaded: [IndexPath] = []
    //下拉刷新调用的方法
    func asyncRequestData()->Void{
        self.tempPage = 1
        _ = HousingMarketApi.provider.request(.housingMarketList).mapResponseToObj(RootClass.self)
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

        _ = HousingMarketApi.provider.request(.housingMarketListNext(ids: ids))
            .mapResponseToObjArray(Newslist.self, dataPath: ["newslist"])
            .subscribe(onNext: { (response) in

            }, onError: { (error) in

            })
        
//        _ = HousingMarketApi.provider.requestWithProgress(.housingMarketListNext(ids: ids)).mapResponseToObjArray(Newslist.self, dataPath: ["newslist"])
//            .subscribe(onNext: { (response) in
//                self.tempPage =  self.tempPage + 1
//                let idListArray = response
//                let length = idListArray.count
//                for i in 0 ..< length{
//                    self.source.append(idListArray[i])
//                }
//                //                let indexPathArray = NSMutableArray.init()
//                //                for i in self.source.count - length...self.source.count - length  {
//                //                    let indexPath = IndexPath(row:i, section: 0)
//                //                    indexPathArray.add(indexPath)
//                //                }
//                //                self.node.performBatch(animated: false, updates: {
//                //                    self.node.insertRows(at: indexPathArray as! [IndexPath], with: .none)
//                //                }, completion: nil)
//                self.node.reloadData()
//
//                self.refreshControl.endLoadingmore();
//        }, onError: { (error) in
//            print(error.rawString())
//            self.refreshControl.endLoadingmore();
//        })
        
//
//        _ = HousingMarketApi.provider.request(.housingMarketListNext(ids: ids)).filterHttpError().mapResponseToObjArray(Newslist.self, dataPath: ["newslist"])
//            .subscribe(onNext: { (response) in
//                self.tempPage =  self.tempPage + 1
//                let idListArray = response
//                let length = idListArray.count
//                for i in 0 ..< length{
//                    self.source.append(idListArray[i])
//                }
////                let indexPathArray = NSMutableArray.init()
////                for i in self.source.count - length...self.source.count - length  {
////                    let indexPath = IndexPath(row:i, section: 0)
////                    indexPathArray.add(indexPath)
////                }
////                self.node.performBatch(animated: false, updates: {
////                    self.node.insertRows(at: indexPathArray as! [IndexPath], with: .none)
////                }, completion: nil)
//                self.node.reloadData()
//
//                self.refreshControl.endLoadingmore();
//            }, onError: { (error) in
//                print(error.rawString())
//                self.refreshControl.endLoadingmore();
//            })
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
        let housMarkVc = UIWebViewController()
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
