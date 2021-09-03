//
//  XZSetting.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/9.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit

let keyPrefix =  "me.XZ.XZSetting."

class XZSetting: NSObject {
    static let sharedInstance = XZSetting()
    
    subscript(key:String) -> String? {
        get {
            return UserDefaults.standard.object(forKey: key) as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key )
        }
    }
    
    func save(){
        UserDefaults.standard.synchronize()
    }

}

extension UserDefaults { //1
    func saveCustomObject(customObject object: NSCoding, key: String) { //2
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
            self.set(data, forKey: "people")
        }catch{
            print(error)
        }
    }
    
    func getCustomObject(forKey key: String) -> AnyObject? { //3
        let decodedObject = self.object(forKey: key) as? NSData
        
        if let decoded = decodedObject {
            let object = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)
            return object as AnyObject
        }
        
        return nil
    }
}
