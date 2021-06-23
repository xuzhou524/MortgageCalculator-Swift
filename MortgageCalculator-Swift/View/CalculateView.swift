//
//  CalculateView.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2021/6/11.
//  Copyright © 2021年 com.longdai. All rights reserved.
//

import UIKit

protocol CalculateDelegate : AnyObject {
    func clickTheButton(view: CalculateView,loanAmount: CGFloat)
}

class CalculateView: UIView,UITextFieldDelegate {

    //定义代理
    weak var delegate:CalculateDelegate?
    var loanAmount:CGFloat = 0.0
    
    init() {
        super.init(frame: CGRect(x: 40, y: XZClient.ScreenHeight() / 2.0 - 230, width: XZClient.ScreenWidth() - 80, height: 300))
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 16;
        self.clipsToBounds = true
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.centerX.equalToSuperview().offset(10)
        }
        
        self.addSubview(self.summeryLabel)
        self.summeryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.left.equalTo(self).offset(30)
        }
        
        self.addSubview(self.unitLabel)
        self.unitLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.summeryLabel)
            make.right.equalTo(self).offset(-30)
        }
        
        self.addSubview(bgView)
        self.textField.tag = 1
        self.textField.addTarget(self, action: #selector(textChange(textField:)), for: .editingChanged)
        self.addSubview(self.textField)
        self.textField.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-75)
            make.left.equalTo(self.summeryLabel.snp.right).offset(15)
            make.height.equalTo(36)
            make.centerY.equalTo(self.summeryLabel)
        }
        self.bgView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.textField)
            make.right.equalTo(self.textField).offset(8)
        }
        
        self.addSubview(self.summeryOneLabel)
        self.summeryOneLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.summeryLabel.snp.bottom).offset(40)
            make.left.equalTo(self).offset(30)
        }
        
        self.addSubview(self.unitsLabel)
        self.unitsLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.summeryOneLabel)
            make.left.equalTo(self.unitLabel)
        }
        
        self.addSubview(bg1View)
        self.oneTextField.tag = 2
        self.oneTextField.addTarget(self, action: #selector(textChange(textField:)), for: .editingChanged)
        self.addSubview(self.oneTextField)
        self.oneTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.summeryOneLabel.snp.right).offset(15)
            make.right.equalTo(self).offset(-75)
            make.height.equalTo(36)
            make.centerY.equalTo(self.summeryOneLabel)
        }
        self.bg1View.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.oneTextField)
            make.right.equalTo(self.oneTextField).offset(8)
        }

        self.addSubview(self.resultLabel)
        self.resultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.summeryOneLabel.snp.bottom).offset(40)
            make.left.equalTo(self).offset(30)
        }
        
        let keyboard1 = XZNumberKeyBoard()
        keyboard1.setInputView(self.textField)

        let keyboard2 = XZNumberKeyBoard()
        keyboard2.setInputView(self.oneTextField)
        
        self.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-20)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(44)
        }
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        panel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(panelTap)))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func panelTap(){
        hide()
    }
    @objc func done() {
        if self.loanAmount > 0.00 {
            self.delegate?.clickTheButton(view: self,loanAmount: self.loanAmount)
        }
    }

    @objc func textChange(textField:UITextField){
        if textField.tag == 2 {
            let r = (textField.text ?? "0") as String
            if (CGFloat(Double(r) ?? 0.0)) > 10.0 {
                textField.text = "10"
            }
            updateView()
        }else{
            updateView()
        }
    }
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont(size: 16)
        label.textColor = XZSwiftColor.xzGlay50
        label.text = "计算需贷款金额"
        return label
    }()
    
    let summeryLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont(size: 15)
        label.textColor = XZSwiftColor.xzGlay50
        label.text = "房价总额"
        return label
    }()
    
    let unitLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont(size: 15)
        label.textColor = XZSwiftColor.xzGlay50
        label.text = "万元"
        return label
    }()

    let textField:UITextField = {
        let textField = UITextField()
        textField.font = XZClient.XZFont(size: 15)
        textField.placeholder = "请输入房价总额"
        textField.textColor = XZSwiftColor.xzGlay50
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let bgView:UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = XZSwiftColor.xzGlay50.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    let summeryOneLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont(size: 15)
        label.textColor = XZSwiftColor.xzGlay50
        label.text = "首付比例"
        return label
    }()
    
    let unitsLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont(size: 15)
        label.textColor = XZSwiftColor.xzGlay50
        label.text = "成"
        return label
    }()
    
    let bg1View:UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = XZSwiftColor.xzGlay50.cgColor
        view.layer.cornerRadius = 5
        return view
    }()

    let oneTextField:UITextField = {
        let textField = UITextField()
        textField.font = XZClient.XZFont(size: 15)
        textField.text = "3"
        textField.textColor = XZSwiftColor.xzGlay50
        textField.textAlignment = .right
        textField.keyboardType = .numberPad
        return textField
    }()
    
    var resultLabel:UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont(size: 15)
        label.textColor = UIColor.init(named: "ic_theme")
        label.text = "需贷款金额：0万元"
        return label
    }()
    
    let doneButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("结果同步至首页", for: .normal)
        btn.setBackgroundImage(UIImage.init(named: "ic_MyLoanBg"), for: .normal)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = XZClient.XZFont(size: 15)
        return btn
    }()

    let panel:UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        view.isUserInteractionEnabled = true
        return view
    }()
    func show() {
        let window = XZClient.shared.mainWindow
        window.addSubview(panel)
        window.addSubview(self)
        
        panel.alpha = 0
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        UIView.animate(withDuration: 0.3) {
            self.panel.alpha = 1
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        self.textField.becomeFirstResponder()
    }
    func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.panel.alpha = 0
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }) { (_) in
            self.panel.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    func updateView() {
        if self.textField.text?.count ?? 0 > 0 && self.oneTextField.text?.count ?? 0 > 0{
            let amontStr = (self.textField.text ?? "0") as String
            let amount = CGFloat(Double(amontStr)!) * 10000.00
            
            let r = (self.oneTextField.text ?? "3") as String
            
            self.loanAmount = amount * (10 - CGFloat(Double(r)!)) * 0.1 / 10000.00
            
            self.resultLabel.text = "需贷款金额：\(loanAmount)万元"
        }else{
            self.loanAmount = 0.00
            self.resultLabel.text = "需贷款金额：0万元"
        }
    }

}
