//
//  HousingMarketManager.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/18.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import RxSwift

class HousingMarketManager: NSObject {
    static let shared = HousingMarketManager()
    
    private override init() {
        super.init()
        syncAndSave()
    }
    
    func syncAndSave(){
        _ = HousingMarketApi.provider.request(.housingMarketList).filterResponseError().mapResponseToObj(HousingMarketModel.self)
        .subscribe(onNext: { (response) in
            
                var arr = response
                
//                let hot = HousingMarketModel()
//                hot.id = 0
//                hot.isPrefix = false
//                hot.name = "hot"
//                hot.nameCn = "新热榜"
//                hot.nameEn = "hot"
//                hot.uri = "hot.json"
//
//                arr.insert(hot, at: 0)
            
                //将数据 保存在文件
                //XZSetting.shared[.subjects] = arr
                
            }, onError: { (error) in
                print( error.rawString() )
            })
    }
}
