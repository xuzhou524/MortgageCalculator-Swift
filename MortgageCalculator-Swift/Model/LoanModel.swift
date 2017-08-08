//
//  LoanModel.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/8.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class LoanModel: NSObject {
    // principal     贷款本金
    // monthRate     月利率
    // totalMonths   还款月数
    // periods       还款月序号
    //每月月供额
    class func averageCapitalPlusInterestMonthAmount(principal:CGFloat , monthRate:CGFloat , totalMonths:Int) -> CGFloat{
        //每月月供额=〔贷款本金×月利率×(1＋月利率)＾还款月数〕÷〔(1＋月利率)＾还款月数-1〕
        return UIScreen.main.bounds.width
    }
    
    //每月应还利息
    class func averageCapitalPlusInterestMonthInterest(principal:CGFloat , monthRate:CGFloat , totalMonths:Int , periods:Int) -> CGFloat{
        //每月应还利息=贷款本金×月利率×〔(1+月利率)^还款月数-(1+月利率)^(还款月序号-1)〕÷〔(1+月利率)^还款月数-1〕
        return UIScreen.main.bounds.width
    }
}
