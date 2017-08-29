//
//  LoanCachemanage.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/21.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

let kTMCacheLoanManage = "kTMCacheLoanManage"
class LoanCacheManage: NSObject , NSCoding {
    
    var  businessPrincipalStr : String?               //商业贷款金额
    var  accumulationPrincipalStr : String?           //公积金贷款金额
    
    var  numberYearStr : String?                      //贷款年限
    
    var  businessRateStr : String?                    //商业利率
    var  accumulationRateStr : String?                //公积金利率
    
    var  loanTypeStr : String?                        //贷款方式        1 商业贷款     2 公积金贷款    3 组合贷款
    var  reimbursementTypeStr : String?               //还款方式        0 等额本金     0 等额本息
    
    var  repaymentDateStr :String?                       //还款日期
    
    var  alsoNumberMonthStr :String?                     //已还期数
    
    var  finalPaymentStr :String?                     //最后还款时间   eg: 20170805
    var  startPaymentStr :String?                     //开始还款时间   eg: 20170805
    
    required override init(){
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        if aDecoder.containsValue(forKey: "businessPrincipalStr") {
            self.businessPrincipalStr = aDecoder.decodeObject(forKey: "businessPrincipalStr") as? String
        }
        if aDecoder.containsValue(forKey: "accumulationPrincipalStr") {
            self.accumulationPrincipalStr = aDecoder.decodeObject(forKey: "accumulationPrincipalStr") as? String
        }
        if aDecoder.containsValue(forKey: "numberYearStr") {
            self.numberYearStr = aDecoder.decodeObject(forKey: "numberYearStr") as? String
        }
        if aDecoder.containsValue(forKey: "businessRateStr") {
            self.businessRateStr = aDecoder.decodeObject(forKey: "businessRateStr") as? String
        }
        if aDecoder.containsValue(forKey: "accumulationRateStr") {
            self.accumulationRateStr = aDecoder.decodeObject(forKey: "accumulationRateStr") as? String
        }
        if aDecoder.containsValue(forKey: "loanTypeStr") {
            self.loanTypeStr = aDecoder.decodeObject(forKey: "loanTypeStr") as? String
        }
        if aDecoder.containsValue(forKey: "reimbursementTypeStr") {
            self.reimbursementTypeStr = aDecoder.decodeObject(forKey: "reimbursementTypeStr") as? String
        }
        if aDecoder.containsValue(forKey: "repaymentDateStr") {
            self.repaymentDateStr = aDecoder.decodeObject(forKey: "repaymentDateStr") as? String
        }
        if aDecoder.containsValue(forKey: "alsoNumberMonthStr") {
            self.alsoNumberMonthStr = aDecoder.decodeObject(forKey: "alsoNumberMonthStr") as? String
        }
        if aDecoder.containsValue(forKey: "finalPaymentStr") {
            self.finalPaymentStr = aDecoder.decodeObject(forKey: "finalPaymentStr") as? String
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.businessPrincipalStr, forKey: "businessPrincipalStr")
        aCoder.encode(self.accumulationPrincipalStr, forKey: "accumulationPrincipalStr")
        aCoder.encode(self.numberYearStr, forKey: "numberYearStr")
        aCoder.encode(self.businessRateStr, forKey: "businessRateStr")
        aCoder.encode(self.accumulationRateStr, forKey: "accumulationRateStr")
        aCoder.encode(self.loanTypeStr, forKey: "loanTypeStr")
        aCoder.encode(self.reimbursementTypeStr, forKey: "reimbursementTypeStr")
        aCoder.encode(self.repaymentDateStr, forKey: "repaymentDateStr")
        aCoder.encode(self.alsoNumberMonthStr, forKey: "alsoNumberMonthStr")
        aCoder.encode(self.finalPaymentStr, forKey: "finalPaymentStr")
    }
    
}
