//
//  LoanModel.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/8.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class LoanModel: NSObject {
    // principal     贷款本金 （单位：元）
    // monthRate     年利率
    // totalMonths   还款月数
    // numberMonth   还款月序号
    
    /*
     *  等额本息
     *
    */
    //每月月供额
    class func averageCapitalPlusInterestMonthAmount(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFloat) -> CGFloat{
        //每月月供额 =〔贷款本金 × 月利率 × (1＋月利率)＾还款月数〕/〔(1＋月利率)＾还款月数-1〕
        return (principal * monthRate / 100 / 12  * pow(1+monthRate / 100 / 12,totalMonths))/(pow(1+monthRate / 100 / 12,totalMonths)-1)
    }
    //每月应还利息
    class func averageCapitalPlusInterestMonthInterest(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFloat , numberMonth:CGFloat) -> CGFloat{
        //每月应还利息 = 贷款本金 × 月利率×〔(1+月利率)^还款月数 - (1+月利率)^(还款月序号-1)〕/〔(1+月利率)^还款月数-1〕
        return (principal * monthRate / 100 / 12 * (pow(1+monthRate / 100 / 12,totalMonths) - pow(1+monthRate / 100 / 12,numberMonth-1))/(pow(1+monthRate / 100 / 12,totalMonths)-1))
    }
    //每月应还本金
    class func averageCapitalPlusInterestMonthPrincipal(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFloat , numberMonth:CGFloat) -> CGFloat{
        //每月应还本金 = 贷款本金 × 月利率 × (1+月利率)^(还款月序号 - 1) /〔(1+月利率)^还款月数-1〕
        return (principal * monthRate / 100 / 12 * pow(1+monthRate / 100 / 12,numberMonth-1)/(pow(1+monthRate / 100 / 12,totalMonths)-1))
    }
    //总利息
    class func averageCapitalPlusInterestTotalInterest(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFloat) -> CGFloat{
        //总利息 = 还款月数 × 每月月供额 - 贷款本金
        let monthAmount = principal * monthRate / 100 / 12 * pow(1+monthRate / 100 / 12,totalMonths)/(pow(1+monthRate / 100 / 12,totalMonths)-1)
        return (totalMonths * monthAmount - principal)
    }
    //剩余本金
    class func averageCapitalPlusInterestRemainingPrincipalTotalInterest(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFloat, numberMonth:CGFloat) -> CGFloat{
        //总利息 = 贷款本金 - 已还本金
        var amount = CGFloat(0)
        for i in 1...NSInteger(numberMonth) {
            amount = amount + self.averageCapitalPlusInterestMonthPrincipal(principal: principal, monthRate: monthRate, totalMonths: totalMonths, numberMonth: CGFloat(i))
        }
        return (principal - amount)
    }
    
    /*
     *  等额本金
     *
     */
    //首月月供额
    class func equalPrincipalFirstMonthAmount(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFloat) -> CGFloat{
        //首月月供额 = (贷款本金 / 还款月数) + 贷款本金 × 月利率
        return (principal / totalMonths) + principal * monthRate / 100 / 12
    }
    //每月月供额
    class func equalPrincipalMonthAmount(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFloat , numberMonth: CGFloat) -> CGFloat{
        //每月月供额 = (贷款本金 / 还款月数) + (贷款本金 - 已归还本金累计额) × 月利率
        return (principal / totalMonths) + (principal - principal / totalMonths * (numberMonth-1)) * monthRate / 100 / 12
    }
    //每月应还利息
    class func equalPrincipalMonthInterest(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFloat , numberMonth:CGFloat) -> CGFloat{
        //每月应还利息 = 剩余本金×月利率 = (贷款本金 - 已归还本金累计额) × 月利率
        return (principal - principal / totalMonths * (numberMonth-1)) * monthRate / 100 / 12
    }
    //每月应还本金
    class func equalPrincipalMonthPrincipal(principal:CGFloat , totalMonths:CGFloat) -> CGFloat{
        //每月应还本金 = 贷款本金 / 还款月数
        return principal / totalMonths
    }
    //总利息
    class func equalPrincipalTotalInterest(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFloat) -> CGFloat{
        //总利息 =〔(贷款本金 / 还款月数 + 贷款本金 × 月利率) + 贷款本金 / 还款月数 × (1+月利率)〕/ 2×还款月数 - 贷款本金
        return ((principal / totalMonths + principal * monthRate / 100 / 12) + principal / totalMonths * (1+monthRate / 100 / 12)) / 2*totalMonths - principal
    }
    //每月月供递减额
    class func equalPrincipalMonthlyDecreaseInMonthlySupply(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFloat) -> CGFloat{
        //每月月供递减额 = 贷款本金 / 还款月数 × 月利率
        return principal / totalMonths * monthRate / 100 / 12
    }
    //剩余本金
    class func equalPrincipalRemainingPrincipalTotalInterest(principal:CGFloat , monthRate:CGFloat , totalMonths:CGFloat, numberMonth:CGFloat) -> CGFloat{
        //总利息 = 贷款本金 - 已还本金
        return (principal - principal / totalMonths * numberMonth)
    }
}
