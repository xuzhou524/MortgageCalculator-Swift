//
//  HousingMarketManager.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/18.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import RxSwift

class HousingMarketManager: NSObject {
    static let shared = HousingMarketManager()
    
    private override init() {
        super.init()
        syncAndSave()
    }
    
    func syncAndSave(){
        
    }
}
