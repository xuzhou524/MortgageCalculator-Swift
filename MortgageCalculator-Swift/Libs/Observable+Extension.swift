//
//  Observable+Extension.swift
//  ChouTi
//
//  Created by huangfeng on 2017/5/18.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper
import SwiftyJSON
import Moya

public enum ApiError : Swift.Error {
    case Error(info: String)
    case AccountBanned(info: String)
    
    
}

extension Swift.Error {
    func rawString() -> String {
        guard let err = self as? ApiError else {
            return ""
        }
        switch err {
        case let .Error(info):
            return info
        case let .AccountBanned(info):
            return info
            //        default:
            //            return ""
        }
    }
}

extension Observable where Element: Moya.Response {
    /// 过滤 HTTP 错误，例如超时，请求失败等
    func filterHttpError() -> Observable<Element> {
        return filter{ response in
            if (200...209) ~= response.statusCode {
                return true
            }
            throw ApiError.Error(info: "网络错误")
        }
    }
    
    /// 过滤逻辑错误，例如协议里返回 错误CODE
    func filterResponseError() -> Observable<Element> {
        return filterHttpError().filter{ response in
            
            let json = JSON(data: response.data)
            var code = 200
            var msg = ""
            if let codeStr = json["code"].rawString(), let c = Int(codeStr)  {
                code = c
            }
            if let m = json["msg"].rawString() {
                msg = m
            }
            if (code == 200){
                return true
            }
            
            switch code {
            case 21104: throw ApiError.AccountBanned(info: msg)
                
            default: throw ApiError.Error(info: msg)
            }
            
        }
    }
    
    
    /// 将Response 转换成 JSON Model
    ///
    /// - Parameters:
    ///   - typeName: 要转换的Model Class
    ///   - dataPath: 从哪个节点开始转换，例如 ["data","links"]
    /// - Returns: <#return value description#>
    func mapResponseToObj<T: Mappable>(_ typeName: T.Type , dataPath:[String] = [] ) -> Observable<T> {
        return filterResponseError().map{ response in
            var rootJson = JSON(data: response.data);
            if dataPath.count > 0{
                rootJson = rootJson[dataPath]
            }
            if let model: T = self.resultFromJSON(json: rootJson)  {
                return model
            }
            else{
                throw ApiError.Error(info: "json 转换失败")
            }
        }
    }
    
    /// 将Response 转换成 JSON Model Array
    func mapResponseToObjArray<T: Mappable>(_ type: T.Type, dataPath:[String] = [] ) -> Observable<[T]> {
        return filterResponseError().map{ response in
            var rootJson = JSON(data: response.data);
            if dataPath.count > 0{
                rootJson = rootJson[dataPath]
            }
            var result = [T]()
            guard let jsonArray = rootJson.array else{
                throw ApiError.Error(info: "data 为 nil");
            }
            
            for json in  jsonArray{
                if let jsonModel: T = self.resultFromJSON(json: json) {
                    result.append(jsonModel)
                }
                else{
                    throw ApiError.Error(info: "json 转换失败")
                }
            }
            
            return result
        }
    }
    
    private func resultFromJSON<T: Mappable>(jsonString:String) -> T? {
        return T(JSONString: jsonString)
    }
    private func resultFromJSON<T: Mappable>(json:JSON) -> T? {
        if let str = json.rawString(){
            return resultFromJSON(jsonString: str)
        }
        return nil
    }
}

