//
//  XZClient.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/2.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class XZClient: NSObject{
    
    class func ScreenWidth() -> CGFloat{
        return UIScreen.main.bounds.width
    }
    
    class func ScreenHeight() -> CGFloat{
        return UIScreen.main.bounds.height
    }
    
    class func XZFont2(size:CGFloat) -> UIFont{
        return  UIFont.init(name: "NotoSansHans-Light", size: size)!
    }
    
    class func XZFont(size:CGFloat) -> UIFont{
        return  UIFont.init(name: "NotoSansHans-DemiLight", size: size)!
    }
    
}
