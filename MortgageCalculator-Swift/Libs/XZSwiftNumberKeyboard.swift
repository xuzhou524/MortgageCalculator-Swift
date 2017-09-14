//
//  XZSwiftNumberKeyboard.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/15.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

@objc protocol  XZSwiftNumberKeyboardDelegate{
    
    @objc optional func editChanage( sender : UIButton)
}

class XZSwiftNumberKeyboard: UIView {
    var delegate: XZSwiftNumberKeyboardDelegate?
    
    var deleteButton : UIButton?    // 退格
    var confirmButton : UIButton?   // 确认
    var dotButton : UIButton?       // .
    var hiddenButton : UIButton?    // 隐藏
    var zeroButton : UIButton?      // 0
    var oneButton : UIButton?       // 1
    var twoButton : UIButton?       // 2
    var threeButton : UIButton?     // 3
    var fourButton : UIButton?      // 4
    var fiveButton : UIButton?      // 5
    var sixButton : UIButton?       // 6
    var sevenButton : UIButton?     // 7
    var eightButton : UIButton?     // 8
    var nineButton : UIButton?      // 9
    
    var textField : UITextField?
    
    func initWithTextField(textField : UITextField){
        self.textField = textField
        self.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.frame = CGRect(x:0, y:Int(XZClient.ScreenWidth() - 150) , width:Int(XZClient.ScreenWidth()/4) , height:150)
        self.setupKeyBoard()
        textField.reloadInputViews()
    }

    func setupKeyBoard() ->Void{
        let space = 1
        let leftSpace = 1
        for i in 0..<9 {
            let str =   String.init(format: "%d",i + 1)
            let button = UIButton.init()
            if (i < 3){
                button.frame = CGRect(x:Int(CGFloat(i % 3)*(XZClient.ScreenWidth()/4 )+CGFloat(leftSpace)), y:i/3*61 , width:Int(XZClient.ScreenWidth()/4-1) , height:60)
            }else{
                button.frame = CGRect(x:Int(CGFloat(i % 3)*(XZClient.ScreenWidth()/4 )+CGFloat(leftSpace)),y:i/3*61,width:Int(XZClient.ScreenWidth()/4-1),height:60)
            }
            button.backgroundColor = XZSwiftColor.white
            button.tintColor = XZSwiftColor.black
            button.titleLabel?.text = str
            button.titleLabel?.font = XZClient.XZFont2(size: 24)
            button.tag = i + 1
            button.addTarget(self, action: #selector(XZSwiftNumberKeyboard.keyBoardAction(button:)), for: .touchUpInside)
            self.addSubview(button)
            if i==0 || i==3||i == 6 {
                 button.frame = CGRect(x:0,y:button.frame.origin.y,width:button.frame.size.width + 1,height:button.frame.size.height)
            }
            self.keyBoardAction(index: i, button: button)
            
            let dotButton = UIButton.init()
            dotButton.frame = CGRect(x:0, y:60*3+3 , width:Int(XZClient.ScreenWidth()/4) , height:60)
            dotButton.backgroundColor = XZSwiftColor.white
            dotButton.tintColor = XZSwiftColor.black
            dotButton.titleLabel?.font = XZClient.XZFont2(size: 24)
            dotButton.addTarget(self, action: #selector(XZSwiftNumberKeyboard.keyBoardAction(button:)), for: .touchUpInside)
            dotButton.titleLabel?.text = "."
            self.addSubview(dotButton)
            self.dotButton = dotButton
            
            let zeroButton = UIButton.init()
            zeroButton.frame = CGRect(x:Int(XZClient.ScreenWidth()/4)+1*space, y:60*3+3 , width:Int(XZClient.ScreenWidth()/4 - 1) , height:60)
            zeroButton.backgroundColor = XZSwiftColor.white
            zeroButton.tintColor = XZSwiftColor.black
            zeroButton.titleLabel?.font = XZClient.XZFont2(size: 24)
            zeroButton.addTarget(self, action: #selector(XZSwiftNumberKeyboard.keyBoardAction(button:)), for: .touchUpInside)
            zeroButton.titleLabel?.text = "0"
            self.addSubview(zeroButton)
            self.zeroButton = zeroButton
            
            
            let hiddenButton = UIButton.init()
            hiddenButton.frame = CGRect(x:Int(XZClient.ScreenWidth()/4)*2*space, y:60*3+3 , width:Int(XZClient.ScreenWidth()/4 - 1) , height:60)
            hiddenButton.backgroundColor = XZSwiftColor.white
            hiddenButton.tintColor = XZSwiftColor.black
            hiddenButton.titleLabel?.font = XZClient.XZFont2(size: 24)
            hiddenButton.addTarget(self, action: #selector(XZSwiftNumberKeyboard.keyBoardAction(button:)), for: .touchUpInside)
            hiddenButton.titleLabel?.text = "隐藏"
            self.addSubview(hiddenButton)
            self.hiddenButton = hiddenButton
            
            let deleteButton = UIButton.init()
            deleteButton.frame = CGRect(x:Int(XZClient.ScreenWidth()/4)*3*space, y:0 , width:Int(XZClient.ScreenWidth()/4) , height:122)
            deleteButton.backgroundColor = XZSwiftColor.white
            deleteButton.tintColor = XZSwiftColor.black
            deleteButton.titleLabel?.font = XZClient.XZFont2(size: 24)
            deleteButton.addTarget(self, action: #selector(XZSwiftNumberKeyboard.keyBoardAction(button:)), for: .touchUpInside)
            deleteButton.titleLabel?.text = "."
            self.addSubview(deleteButton)
            self.deleteButton = deleteButton
            
            let confirmbutton = UIButton.init()
            confirmbutton.frame = CGRect(x:Int(XZClient.ScreenWidth()/4)*3*space, y:61*2 , width:Int(XZClient.ScreenWidth()/4) , height:122)
            confirmbutton.backgroundColor = XZSwiftColor.white
            confirmbutton.tintColor = XZSwiftColor.black
            confirmbutton.titleLabel?.font = XZClient.XZFont2(size: 24)
            confirmbutton.addTarget(self, action: #selector(XZSwiftNumberKeyboard.keyBoardAction(button:)), for: .touchUpInside)
            confirmbutton.titleLabel?.text = "确定"
            self.addSubview(confirmbutton)
            self.confirmButton = confirmbutton
            
        }
    }
    
    func keyBoardAction(button:UIButton) ->Void{
        let btn = button
        let number = btn.tag
        if number <= 9 && number >= 0{
            self.numberKeyBoard(number: number)
            return
        }
        if 10 == number { //删除
            self.cancelKeyBoard()
            return
        }
        if 11 == number { //点
            self.periodKeyBoard()
            return
        }
        if 12 == number { //负号
            self.minusKeyBoard()
            return
        }
        if 13 == number { //确定
            self.finishKeyBoard()
            return
        }
        
    }
    
    func keyBoardAction(index : NSInteger ,button: UIButton) ->Void{
        switch (index) {
        case 0:
            self.oneButton = button
            break
        case 1:
            self.twoButton = button
            break
        case 2:
            self.threeButton = button
            break
        case 3:
            self.fourButton = button
            break
        case 4:
            self.fiveButton = button
            break
        case 5:
            self.sixButton = button
            break
        case 6:
            self.sevenButton = button
            break
        case 7:
            self.eightButton = button
            break
        case 8:
            self.nineButton = button
            break
            
        default:
            break
        }
    }
    
    func numberKeyBoard(number:NSInteger) ->Void{
       let beginning = self.textField?.beginningOfDocument
       let selectefRange = self.textField?.selectedTextRange
        let selectionStart = selectefRange?.start
        let selectionEnd = selectefRange?.end
        
        let location = self.textField?.offset(from: beginning!, to: selectionStart!)
        let length = self.textField?.offset(from: selectionStart!, to: selectionEnd!)
        //let string = (self.textField?.text! as String).substring(to: location ?? 1)
        let str = self.textField?.text
        
        print("%d",length ?? 1)
        print("%d",location ?? 1)
        //print("%@",string)
        print("%@",str ?? "1")
        
    }
    
    func cancelKeyBoard() ->Void{
        
        
    }
    
    func periodKeyBoard() ->Void{
        
        
    }
    
    func minusKeyBoard() ->Void{
        
        
    }
    
    func finishKeyBoard() ->Void{
        if (self.textField != nil) {
            self.textField?.resignFirstResponder
        }
    }
    
    override func reloadInputViews() ->Void{
        if (self.textField != nil) {
            self.textField?.inputView = nil;
            self.textField?.resignFirstResponder
        }
    }
}
