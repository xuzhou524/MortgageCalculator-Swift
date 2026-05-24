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
        if numberMonth <= 0 {
            return 0;
        }
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
    
    /*
     *  提前还款计算
     *
     */
    
    // 等额本息：计算提前还款后的剩余本金
    class func prepaymentACPIRemainingPrincipal(principal: CGFloat, monthRate: CGFloat, totalMonths: CGFloat, paidMonths: CGFloat, prepaymentAmount: CGFloat) -> CGFloat {
        let remainingPrincipal = self.averageCapitalPlusInterestRemainingPrincipalTotalInterest(principal: principal, monthRate: monthRate, totalMonths: totalMonths, numberMonth: paidMonths)
        return max(0, remainingPrincipal - prepaymentAmount)
    }
    
    // 等额本金：计算提前还款后的剩余本金
    class func prepaymentEPRemainingPrincipal(principal: CGFloat, monthRate: CGFloat, totalMonths: CGFloat, paidMonths: CGFloat, prepaymentAmount: CGFloat) -> CGFloat {
        let remainingPrincipal = self.equalPrincipalRemainingPrincipalTotalInterest(principal: principal, monthRate: monthRate, totalMonths: totalMonths, numberMonth: paidMonths)
        return max(0, remainingPrincipal - prepaymentAmount)
    }
    
    // 等额本息：计算提前还款后的月供（缩短还款期限方式）
    class func prepaymentACPINewMonthAmount(principal: CGFloat, monthRate: CGFloat, totalMonths: CGFloat, paidMonths: CGFloat, prepaymentAmount: CGFloat) -> CGFloat {
        let remainingPrincipal = self.prepaymentACPIRemainingPrincipal(principal: principal, monthRate: monthRate, totalMonths: totalMonths, paidMonths: paidMonths, prepaymentAmount: prepaymentAmount)
        let remainingMonths = totalMonths - paidMonths
        
        if remainingPrincipal <= 0 || remainingMonths <= 0 {
            return 0
        }
        
        return self.averageCapitalPlusInterestMonthAmount(principal: remainingPrincipal, monthRate: monthRate, totalMonths: remainingMonths)
    }
    
    // 等额本金：计算提前还款后的月供（缩短还款期限方式）
    class func prepaymentEPNewMonthAmount(principal: CGFloat, monthRate: CGFloat, totalMonths: CGFloat, paidMonths: CGFloat, prepaymentAmount: CGFloat) -> CGFloat {
        let remainingPrincipal = self.prepaymentEPRemainingPrincipal(principal: principal, monthRate: monthRate, totalMonths: totalMonths, paidMonths: paidMonths, prepaymentAmount: prepaymentAmount)
        let remainingMonths = totalMonths - paidMonths
        
        if remainingPrincipal <= 0 || remainingMonths <= 0 {
            return 0
        }
        
        return self.equalPrincipalFirstMonthAmount(principal: remainingPrincipal, monthRate: monthRate, totalMonths: remainingMonths)
    }
    
    // 计算提前还款后的剩余还款月数（保持月供不变方式）
    class func prepaymentNewTotalMonths(principal: CGFloat, monthRate: CGFloat, originalTotalMonths: CGFloat, paidMonths: CGFloat, prepaymentAmount: CGFloat, originalMonthAmount: CGFloat) -> CGFloat {
        let remainingPrincipal = self.averageCapitalPlusInterestRemainingPrincipalTotalInterest(principal: principal, monthRate: monthRate, totalMonths: originalTotalMonths, numberMonth: paidMonths) - prepaymentAmount
        
        if remainingPrincipal <= 0 || originalMonthAmount <= 0 {
            return 0
        }
        
        let monthlyRate = monthRate / 100 / 12
        // 月供公式: A = P * r * (1+r)^n / ((1+r)^n - 1)
        // 反推n: n = log(A/(A-P*r)) / log(1+r)
        let numerator = log(originalMonthAmount / (originalMonthAmount - remainingPrincipal * monthlyRate))
        let denominator = log(1 + monthlyRate)
        
        return numerator / denominator
    }
    
    // 计算利息节省（等额本息）
    class func interestSavedACPI(principal: CGFloat, monthRate: CGFloat, totalMonths: CGFloat, paidMonths: CGFloat, prepaymentAmount: CGFloat) -> CGFloat {
        // 原计划总利息
        let originalTotalInterest = self.averageCapitalPlusInterestTotalInterest(principal: principal, monthRate: monthRate, totalMonths: totalMonths)
        
        // 已还利息
        var paidInterest: CGFloat = 0
        for i in 1...Int(paidMonths) {
            paidInterest += self.averageCapitalPlusInterestMonthInterest(principal: principal, monthRate: monthRate, totalMonths: totalMonths, numberMonth: CGFloat(i))
        }
        
        // 提前还款后剩余本金
        let remainingPrincipal = self.prepaymentACPIRemainingPrincipal(principal: principal, monthRate: monthRate, totalMonths: totalMonths, paidMonths: paidMonths, prepaymentAmount: prepaymentAmount)
        let remainingMonths = totalMonths - paidMonths
        
        // 提前还款后剩余利息
        let remainingInterest = self.averageCapitalPlusInterestTotalInterest(principal: remainingPrincipal, monthRate: monthRate, totalMonths: remainingMonths)
        
        // 利息节省 = 原计划总利息 - (已还利息 + 剩余利息)
        return originalTotalInterest - (paidInterest + remainingInterest)
    }
    
    // 计算利息节省（等额本金）
    class func interestSavedEP(principal: CGFloat, monthRate: CGFloat, totalMonths: CGFloat, paidMonths: CGFloat, prepaymentAmount: CGFloat) -> CGFloat {
        // 原计划总利息
        let originalTotalInterest = self.equalPrincipalTotalInterest(principal: principal, monthRate: monthRate, totalMonths: totalMonths)
        
        // 已还利息
        var paidInterest: CGFloat = 0
        for i in 1...Int(paidMonths) {
            paidInterest += self.equalPrincipalMonthInterest(principal: principal, monthRate: monthRate, totalMonths: totalMonths, numberMonth: CGFloat(i))
        }
        
        // 提前还款后剩余本金
        let remainingPrincipal = self.prepaymentEPRemainingPrincipal(principal: principal, monthRate: monthRate, totalMonths: totalMonths, paidMonths: paidMonths, prepaymentAmount: prepaymentAmount)
        let remainingMonths = totalMonths - paidMonths
        
        // 提前还款后剩余利息
        let remainingInterest = self.equalPrincipalTotalInterest(principal: remainingPrincipal, monthRate: monthRate, totalMonths: remainingMonths)
        
        // 利息节省 = 原计划总利息 - (已还利息 + 剩余利息)
        return originalTotalInterest - (paidInterest + remainingInterest)
    }
    
    // 计算提前还款后的总利息（等额本息）
    class func prepaymentNewTotalInterestACPI(principal: CGFloat, monthRate: CGFloat, totalMonths: CGFloat, paidMonths: CGFloat, prepaymentAmount: CGFloat) -> CGFloat {
        // 已还利息
        var paidInterest: CGFloat = 0
        for i in 1...Int(paidMonths) {
            paidInterest += self.averageCapitalPlusInterestMonthInterest(principal: principal, monthRate: monthRate, totalMonths: totalMonths, numberMonth: CGFloat(i))
        }
        
        // 提前还款后剩余本金
        let remainingPrincipal = self.prepaymentACPIRemainingPrincipal(principal: principal, monthRate: monthRate, totalMonths: totalMonths, paidMonths: paidMonths, prepaymentAmount: prepaymentAmount)
        let remainingMonths = totalMonths - paidMonths
        
        // 提前还款后剩余利息
        let remainingInterest = self.averageCapitalPlusInterestTotalInterest(principal: remainingPrincipal, monthRate: monthRate, totalMonths: remainingMonths)
        
        return paidInterest + remainingInterest
    }
    
    // 计算提前还款后的总利息（等额本金）
    class func prepaymentNewTotalInterestEP(principal: CGFloat, monthRate: CGFloat, totalMonths: CGFloat, paidMonths: CGFloat, prepaymentAmount: CGFloat) -> CGFloat {
        // 已还利息
        var paidInterest: CGFloat = 0
        for i in 1...Int(paidMonths) {
            paidInterest += self.equalPrincipalMonthInterest(principal: principal, monthRate: monthRate, totalMonths: totalMonths, numberMonth: CGFloat(i))
        }
        
        // 提前还款后剩余本金
        let remainingPrincipal = self.prepaymentEPRemainingPrincipal(principal: principal, monthRate: monthRate, totalMonths: totalMonths, paidMonths: paidMonths, prepaymentAmount: prepaymentAmount)
        let remainingMonths = totalMonths - paidMonths
        
        // 提前还款后剩余利息
        let remainingInterest = self.equalPrincipalTotalInterest(principal: remainingPrincipal, monthRate: monthRate, totalMonths: remainingMonths)
        
        return paidInterest + remainingInterest
    }
}
