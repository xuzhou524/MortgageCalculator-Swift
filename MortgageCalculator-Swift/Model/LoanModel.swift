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
    // numberMonth   还款月序号
    
    /*
     *  等额本息
     *
    */
    
    //每月月供额
    class func averageCapitalPlusInterestMonthAmount(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFont) -> CGFloat{
        //每月月供额 =〔贷款本金 × 月利率 × (1＋月利率)＾还款月数〕/〔(1＋月利率)＾还款月数-1〕
        return (principal * monthRate * pow(1+monthRate,totalMonths as! CGFloat)/(pow(1+monthRate,totalMonths as! CGFloat)-1))
    }
    
    //每月应还利息
    class func averageCapitalPlusInterestMonthInterest(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFont , numberMonth:CGFont) -> CGFloat{
        //每月应还利息 = 贷款本金 × 月利率×〔(1+月利率)^还款月数 - (1+月利率)^(还款月序号-1)〕/〔(1+月利率)^还款月数-1〕
        return UIScreen.main.bounds.width
    }
    
    //每月应还本金
    class func averageCapitalPlusInterestMonthPrincipal(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFont , numberMonth:CGFont) -> CGFloat{
        //每月应还本金 = 贷款本金 × 月利率 × (1+月利率)^(还款月序号 - 1) /〔(1+月利率)^还款月数-1〕
        return UIScreen.main.bounds.width
    }
    
    //总利息
    class func averageCapitalPlusInterestTotalInterest(principal:CGFloat , totalMonths:CGFont , monthAmount:CGFloat) -> CGFloat{
        //总利息 = 还款月数 × 每月月供额 - 贷款本金
        return UIScreen.main.bounds.width
    }
    
    /*
     *  等额本金
     *
     */
    
    //每月月供额
    class func equalPrincipalMonthAmount(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFont) -> CGFloat{
        //每月月供额 = (贷款本金 / 还款月数) + (贷款本金 - 已归还本金累计额) × 月利率
        return UIScreen.main.bounds.width
    }
    
    //每月应还利息
    class func equalPrincipalMonthInterest(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFont , numberMonth:CGFont) -> CGFloat{
        //每月应还利息 = 剩余本金×月利率 = (贷款本金 - 已归还本金累计额) × 月利率
        return UIScreen.main.bounds.width
    }
    
    //每月应还本金
    class func equalPrincipalMonthPrincipal(principal:CGFloat , totalMonths:CGFont) -> CGFloat{
        //每月应还本金 = 贷款本金 / 还款月数
        return UIScreen.main.bounds.width
    }
    
    //总利息
    class func equalPrincipalTotalInterest(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFont , monthAmount:CGFloat) -> CGFloat{
        //总利息 =〔(贷款本金 / 还款月数 + 贷款本金 × 月利率) + 贷款本金 / 还款月数 × (1+月利率)〕/ 2×还款月数 - 贷款本金
        return UIScreen.main.bounds.width
    }
    
    //每月月供递减额
    class func equalPrincipalMonthlyDecreaseInMonthlySupply(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFont) -> CGFloat{
        //每月月供递减额 = 贷款本金 / 还款月数 × 月利率
        return UIScreen.main.bounds.width
    }
    
}
