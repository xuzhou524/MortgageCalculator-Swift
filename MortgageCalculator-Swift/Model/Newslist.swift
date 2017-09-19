//
//	Newslist.swift
//
//	Create by xuzhou on 19/9/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Newslist : NSObject, NSCoding, Mappable{

	var abstractField : String?
	var articletype : String?
	var comment : String?
	var commentid : String?
	var flag : String?
	var graphicLiveID : String?
	var id : String?
	var imagecount : Int?
	var origUrl : String?
	var qishu : String?
	var source : String?
	var surl : String?
	var tag : [String]?
	var thumbnails : [String]?
	var thumbnailsQqnews : [String]?
	var time : String?
	var timestamp : Int?
	var title : String?
	var uinname : String?
	var uinnick : String?
	var url : String?
	var videoTotalTime : String?
	var voteId : String?
	var voteNum : String?
	var weiboid : String?


	class func newInstance(map: Map) -> Mappable?{
		return Newslist()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		abstractField <- map["abstract"]
		articletype <- map["articletype"]
		comment <- map["comment"]
		commentid <- map["commentid"]
		flag <- map["flag"]
		graphicLiveID <- map["graphicLiveID"]
		id <- map["id"]
		imagecount <- map["imagecount"]
		origUrl <- map["origUrl"]
		qishu <- map["qishu"]
		source <- map["source"]
		surl <- map["surl"]
		tag <- map["tag"]
		thumbnails <- map["thumbnails"]
		thumbnailsQqnews <- map["thumbnails_qqnews"]
		time <- map["time"]
		timestamp <- map["timestamp"]
		title <- map["title"]
		uinname <- map["uinname"]
		uinnick <- map["uinnick"]
		url <- map["url"]
		videoTotalTime <- map["videoTotalTime"]
		voteId <- map["voteId"]
		voteNum <- map["voteNum"]
		weiboid <- map["weiboid"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         abstractField = aDecoder.decodeObject(forKey: "abstract") as? String
         articletype = aDecoder.decodeObject(forKey: "articletype") as? String
         comment = aDecoder.decodeObject(forKey: "comment") as? String
         commentid = aDecoder.decodeObject(forKey: "commentid") as? String
         flag = aDecoder.decodeObject(forKey: "flag") as? String
         graphicLiveID = aDecoder.decodeObject(forKey: "graphicLiveID") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         imagecount = aDecoder.decodeObject(forKey: "imagecount") as? Int
         origUrl = aDecoder.decodeObject(forKey: "origUrl") as? String
         qishu = aDecoder.decodeObject(forKey: "qishu") as? String
         source = aDecoder.decodeObject(forKey: "source") as? String
         surl = aDecoder.decodeObject(forKey: "surl") as? String
         tag = aDecoder.decodeObject(forKey: "tag") as? [String]
         thumbnails = aDecoder.decodeObject(forKey: "thumbnails") as? [String]
         thumbnailsQqnews = aDecoder.decodeObject(forKey: "thumbnails_qqnews") as? [String]
         time = aDecoder.decodeObject(forKey: "time") as? String
         timestamp = aDecoder.decodeObject(forKey: "timestamp") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
         uinname = aDecoder.decodeObject(forKey: "uinname") as? String
         uinnick = aDecoder.decodeObject(forKey: "uinnick") as? String
         url = aDecoder.decodeObject(forKey: "url") as? String
         videoTotalTime = aDecoder.decodeObject(forKey: "videoTotalTime") as? String
         voteId = aDecoder.decodeObject(forKey: "voteId") as? String
         voteNum = aDecoder.decodeObject(forKey: "voteNum") as? String
         weiboid = aDecoder.decodeObject(forKey: "weiboid") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if abstractField != nil{
			aCoder.encode(abstractField, forKey: "abstract")
		}
		if articletype != nil{
			aCoder.encode(articletype, forKey: "articletype")
		}
		if comment != nil{
			aCoder.encode(comment, forKey: "comment")
		}
		if commentid != nil{
			aCoder.encode(commentid, forKey: "commentid")
		}
		if flag != nil{
			aCoder.encode(flag, forKey: "flag")
		}
		if graphicLiveID != nil{
			aCoder.encode(graphicLiveID, forKey: "graphicLiveID")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if imagecount != nil{
			aCoder.encode(imagecount, forKey: "imagecount")
		}
		if origUrl != nil{
			aCoder.encode(origUrl, forKey: "origUrl")
		}
		if qishu != nil{
			aCoder.encode(qishu, forKey: "qishu")
		}
		if source != nil{
			aCoder.encode(source, forKey: "source")
		}
		if surl != nil{
			aCoder.encode(surl, forKey: "surl")
		}
		if tag != nil{
			aCoder.encode(tag, forKey: "tag")
		}
		if thumbnails != nil{
			aCoder.encode(thumbnails, forKey: "thumbnails")
		}
		if thumbnailsQqnews != nil{
			aCoder.encode(thumbnailsQqnews, forKey: "thumbnails_qqnews")
		}
		if time != nil{
			aCoder.encode(time, forKey: "time")
		}
		if timestamp != nil{
			aCoder.encode(timestamp, forKey: "timestamp")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if uinname != nil{
			aCoder.encode(uinname, forKey: "uinname")
		}
		if uinnick != nil{
			aCoder.encode(uinnick, forKey: "uinnick")
		}
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}
		if videoTotalTime != nil{
			aCoder.encode(videoTotalTime, forKey: "videoTotalTime")
		}
		if voteId != nil{
			aCoder.encode(voteId, forKey: "voteId")
		}
		if voteNum != nil{
			aCoder.encode(voteNum, forKey: "voteNum")
		}
		if weiboid != nil{
			aCoder.encode(weiboid, forKey: "weiboid")
		}

	}

}