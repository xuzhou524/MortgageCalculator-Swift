//
//  HousingMarketApi.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/18.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import Moya

//"http://xw.qq.com/service/api/proxy?key=Xw@2017Mmd&charset=utf-8&url=http://openapi.inews.qq.com/getQQNewsIndexAndItems?chlid=news_news_house&refer=mobilewwwqqcom&otype=json"


enum HousingMarketApi {
    /// 全部楼市列表
   case housingMarketList
   case housingMarketListNext(ids: String)
}

extension HousingMarketApi: XZTargetType {
    var headers: [String : String]? {
        return nil
    }
    
    var path: String {
       return "/service/api/proxy"
    }
    
    var method: Moya.Method {
        switch self {
        case .housingMarketList:
            return .get
        case  .housingMarketListNext(_):
            return .get
        }
    }

    var parameters: [String : Any]? {
        var params = [String:Any]()
        switch self {
        case .housingMarketList:
            params["key"] = "Xw@2017Mmd"
            params["charset"] = "utf-8"
            params["url"] = "http://openapi.inews.qq.com/getQQNewsIndexAndItems?chlid=news_news_house&refer=mobilewwwqqcom&otype=json"
            return params
        case  let .housingMarketListNext(ids):
            params["key"] = "Xw@2017Mmd"
            params["charset"] = "utf-8"
            if  ids != nil {
                 params["url"] = "http://openapi.inews.qq.com/getQQNewsNormalContent?ids=" + ids + "&refer=mobilewwwqqcom&otype=json"
            }
            return params
        }
    }
}
