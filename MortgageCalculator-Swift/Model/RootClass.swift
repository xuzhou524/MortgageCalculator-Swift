//
//	RootClass.swift
//
//	Create by xuzhou on 19/9/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class RootClass : NSObject, NSCoding, Mappable{

	var idlist : [Idlist]?
	var ret : Int?


	class func newInstance(map: Map) -> Mappable?{
		return RootClass()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		idlist <- map["idlist"]
		ret <- map["ret"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         idlist = aDecoder.decodeObject(forKey: "idlist") as? [Idlist]
         ret = aDecoder.decodeObject(forKey: "ret") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if idlist != nil{
			aCoder.encode(idlist, forKey: "idlist")
		}
		if ret != nil{
			aCoder.encode(ret, forKey: "ret")
		}

	}

}