//
//  lifeHeadView.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/10/18.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class LifeView: UIView {

    let iconImageView : UIImageView = {
        let iconImageView = UIImageView()
        //iconImageView.backgroundColor = XZSwiftColor.red
        return iconImageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = XZClient.XZFont2(size: 14)
        titleLabel.textColor = XZSwiftColor.xzGlay50
        return titleLabel
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: XZClient.ScreenWidth()/4.0, height: 80))
        self.addSubview(iconImageView)
        iconImageView.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(self).offset(15)
            make.centerX.equalTo(self)
            make.width.height.equalTo(40)
        });
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints({ (make) -> Void in
            make.centerX.equalTo(iconImageView)
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
        });
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LifeHeadView: UIView {
    
    var headViewArray : NSMutableArray = []
    
    init(imageArray:NSMutableArray,titleArray:NSMutableArray){
        
        let height = 80
        super.init(frame: CGRect(x: 0, y: 0, width: Int(XZClient.ScreenWidth()), height: ((titleArray.count % 4 == 0 ? titleArray.count / 4 : titleArray.count / 4 + 1)) * height + 25))
        
        for i in 0 ..< titleArray.count{
            
            let titleStr : String = titleArray[i] as! String
            let imageStr : String = imageArray[i] as! String
        
            let lifeView = LifeView()
            lifeView.titleLabel.text = titleStr
            lifeView.iconImageView.image = UIImage.init(named: imageStr)
            lifeView.tag = 100 + i
            self.addSubview(lifeView)
            
            lifeView.snp.makeConstraints({ (make) -> Void in
                make.top.equalTo(self).offset(i / 4 * height)
                make.height.equalTo(height)
                make.left.equalTo( CGFloat(i % 4) * XZClient.ScreenWidth()/4.0)
                make.width.equalTo(XZClient.ScreenWidth()/4.0)
            });
            
            headViewArray.add(lifeView)
            
        }
        
        let sepView = UIView()
        sepView.backgroundColor = XZSwiftColor.xzGlay230
        self.addSubview(sepView)
        sepView.snp.makeConstraints({ (make) -> Void in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(10)
        });
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


