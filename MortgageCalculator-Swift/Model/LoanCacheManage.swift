//
//  LoanCachemanage.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/21.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

// principal     贷款本金 （单位：元）
// monthRate     年利率
// totalMonths   还款月数
// numberMonth   还款月序号

class LoanCacheManage: NSObject , NSCoding {
    
    var  businessPrincipalStr : String?
    var  accumulationPrincipalStr : String?
    
    var  numberYearStr : String?
    
    var  businessRateStr : String?
    var  accumulationRateStr : String?
    
    var  loanTypeStr : String?
    var  reimbursementTypeStr : String?
    
    var  repaymentDate :String?
    var  alsoNumberMonth :String?
    
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
        if aDecoder.containsValue(forKey: "repaymentDate") {
            self.repaymentDate = aDecoder.decodeObject(forKey: "repaymentDate") as? String
        }
        if aDecoder.containsValue(forKey: "alsoNumberMonth") {
            self.alsoNumberMonth = aDecoder.decodeObject(forKey: "alsoNumberMonth") as? String
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
        aCoder.encode(self.repaymentDate, forKey: "repaymentDate")
        aCoder.encode(self.alsoNumberMonth, forKey: "alsoNumberMonth")
    }
    
}
