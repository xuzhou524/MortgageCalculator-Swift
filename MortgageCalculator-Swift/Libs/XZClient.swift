//
//  XZClient.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/2.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class XZClient: NSObject{
    
    static let shared = XZClient()
    private override init() {
        super.init()
    }
    
    var mainWindow:UIWindow {
        get {
            let array = UIApplication.shared.windows
            let windowScene = array.first
            return windowScene ?? UIWindow()
        }
    }
    
    class func ScreenWidth() -> CGFloat{
        return UIScreen.main.bounds.width
    }
    
    class func ScreenHeight() -> CGFloat{
        return UIScreen.main.bounds.height
    }
    
    class func XZFont(size:CGFloat) -> UIFont{
        return  UIFont.init(name: "NotoSansHans-DemiLight", size: size)!
    }
    
    class func XZFont2(size:CGFloat) -> UIFont{
        return  UIFont.init(name: "NotoSansHans-Light", size: size)!
    }
    
    class func XZFont3(size:CGFloat) -> UIFont{
        return  UIFont.init(name: "Helvetica-Bold", size: size)!
    }
    
    class func XZiPhoneX() -> Bool {
        
        let statusBarManager:UIStatusBarManager = UIApplication.shared.windows.first!.windowScene!.statusBarManager!
        let statusBarHeight = Double(Int(statusBarManager.statusBarFrame.size.height));
        return statusBarHeight == 44 ? true : false
    }
}

extension UIView {
    /// 设置阴影
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - offset: 阴影偏移量
    ///   - opacity: 阴影透明度
    ///   - radius: 阴影半径
    func addShadow(color: UIColor, offset:CGSize, opacity:Float, radius:CGFloat) {
//        self.layer.masksToBounds = true
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        
        let shadowRect: CGRect? = CGRect.init(x: -radius, y: -radius, width: bounds.size.width + 2 * radius, height: bounds.size.height + 2 * radius)

        self.layer.shadowPath = UIBezierPath.init(rect: shadowRect!).cgPath
    
    }
    
    func addRoundedCorners(corners:UIRectCorner,radii:CGSize,rect:CGRect) {
        let rounded = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        self.layer.mask = shape
    }
}
