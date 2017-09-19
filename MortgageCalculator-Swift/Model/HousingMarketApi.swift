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
    /// 楼市列表
   case housingMarketList
}

extension HousingMarketApi: XZTargetType {
    
    var path: String {
       return "/service/api/proxy"
    }
    
    var method: Moya.Method {
            return .get
        
    }

    var parameters: [String : Any]? {
        var params = [String:Any]()
        params["key"] = "Xw@2017Mmd"
        params["charset"] = "utf-8"
        params["url"] = "http://openapi.inews.qq.com/getQQNewsIndexAndItems?chlid=news_news_house&refer=mobilewwwqqcom&otype=json"
        return params
    }
}
