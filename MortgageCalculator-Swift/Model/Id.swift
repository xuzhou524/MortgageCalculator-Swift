//
//	Id.swift
//
//	Create by xuzhou on 19/9/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Id : NSObject, NSCoding, Mappable{

	var comments : Int?
	var exist : Int?
	var hidepic : Int?
	var id : String?
	var videoHits : Int?


	class func newInstance(map: Map) -> Mappable?{
		return Id()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		comments <- map["comments"]
		exist <- map["exist"]
		hidepic <- map["hidepic"]
		id <- map["id"]
		videoHits <- map["video_hits"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         comments = aDecoder.decodeObject(forKey: "comments") as? Int
         exist = aDecoder.decodeObject(forKey: "exist") as? Int
         hidepic = aDecoder.decodeObject(forKey: "hidepic") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? String
         videoHits = aDecoder.decodeObject(forKey: "video_hits") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if comments != nil{
			aCoder.encode(comments, forKey: "comments")
		}
		if exist != nil{
			aCoder.encode(exist, forKey: "exist")
		}
		if hidepic != nil{
			aCoder.encode(hidepic, forKey: "hidepic")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if videoHits != nil{
			aCoder.encode(videoHits, forKey: "video_hits")
		}

	}

}