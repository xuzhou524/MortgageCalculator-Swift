//
//	Idlist.swift
//
//	Create by xuzhou on 19/9/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Idlist : NSObject, NSCoding, Mappable{

	var ids : [Id]?
	var newslist : [Newslist]?
	var section : String?


	class func newInstance(map: Map) -> Mappable?{
		return Idlist()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		ids <- map["ids"]
		newslist <- map["newslist"]
		section <- map["section"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         ids = aDecoder.decodeObject(forKey: "ids") as? [Id]
         newslist = aDecoder.decodeObject(forKey: "newslist") as? [Newslist]
         section = aDecoder.decodeObject(forKey: "section") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if ids != nil{
			aCoder.encode(ids, forKey: "ids")
		}
		if newslist != nil{
			aCoder.encode(newslist, forKey: "newslist")
		}
		if section != nil{
			aCoder.encode(section, forKey: "section")
		}

	}

}