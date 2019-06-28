//
//  XZTargetType.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/18.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import Moya
import Result
import RxSwift

//保存全局Providers
fileprivate var retainProviders:[String: Any] = [:]

protocol XZTargetType: TargetType {}

extension XZTargetType {
    var baseURL: URL {
        return URL(string: "http://xw.qq.com")!
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return requestTaskWithParameters
    }

    var requestTaskWithParameters : Task {
        get {
            let defaultParameters: [String : Any] = ["version":"100"]
            return Task.requestParameters(parameters: defaultParameters, encoding: URLEncoding.default)
        }
    }
    
    static var networkActivityPlugin: PluginType {
        return NetworkActivityPlugin { (change, type) in
            switch change {
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
            case .ended:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    static func endpointClosure<T:TargetType>(_ target: T) -> Endpoint{
        let defaultEndpoint = MoyaProvider<T>.defaultEndpointMapping(for: target)
        
        //API请求 默认携带的参数
//        var version = "0.0.0"
//        if let infoDict = Bundle.main.infoDictionary {
//            if let appVersion = infoDict["CFBundleShortVersionString"] as? String {
//                version = appVersion
//            }
//        }
//        var defaultParameters: [String : Any] = ["deviceId": UDID.udid,
//                                                 "source": APP_KEY_iPhone,
//                                                 "version":version]
//
//        if User.shared.isLogin {
//            defaultParameters["access_token"] = APP_KEY_iPhone + User.shared.accessToken
//        }
        
        return defaultEndpoint
    }
    
    /// 实现此协议的类，将自动获得用该类实例化的 provider 对象
    static var provider: RxSwift.Reactive< MoyaProvider<Self> > {
        let key = "\(Self.self)"
        if let provider = retainProviders[key] as? RxSwift.Reactive< MoyaProvider<Self> > {
            return provider
        }
        let provider = Self.sprovider
        retainProviders[key] = provider
        return provider
    }
    
    /// 实现此协议的类，将自动获得用该类实例化的 provider 对象
    static var sprovider: RxSwift.Reactive< MoyaProvider<Self> > {
        let plugins:[PluginType] = [networkActivityPlugin]
        let provider = MoyaProvider<Self>(plugins:plugins)
        return provider.rx
        
    }
}
