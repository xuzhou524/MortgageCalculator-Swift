//
//  HousingMarketModel.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/18.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import Foundation
import ObjectMapper

class HousingMarketModel : NSObject, NSCoding, Mappable ,Codable{
    
    var id : Int?
    var isPrefix : Bool?
    var name : String?
    var nameCn : String?
    var nameEn : String?
    var uri : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return HousingMarketModel()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map)
    {
        id <- map["id"]
        isPrefix <- map["is_prefix"]
        name <- map["name"]
        nameCn <- map["name_cn"]
        nameEn <- map["name_en"]
        uri <- map["uri"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        isPrefix = aDecoder.decodeObject(forKey: "is_prefix") as? Bool
        name = aDecoder.decodeObject(forKey: "name") as? String
        nameCn = aDecoder.decodeObject(forKey: "name_cn") as? String
        nameEn = aDecoder.decodeObject(forKey: "name_en") as? String
        uri = aDecoder.decodeObject(forKey: "uri") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if isPrefix != nil{
            aCoder.encode(isPrefix, forKey: "is_prefix")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if nameCn != nil{
            aCoder.encode(nameCn, forKey: "name_cn")
        }
        if nameEn != nil{
            aCoder.encode(nameEn, forKey: "name_en")
        }
        if uri != nil{
            aCoder.encode(uri, forKey: "uri")
        }
        
    }
    
}
