//
//  BaseTableViewCell.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/8/1.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel?
    var bgTextFieldView : UIView?
    var textField: UITextField?
    
    var summeryLabel: UILabel?
    
    var topSepView : UIImageView?
    var bottomSepView : UIImageView?
    var bottomShortSepView : UIImageView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    func sebView() ->Void{
        self.selectionStyle = .none
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.titleLabel = UILabel()
        self.titleLabel?.text = "贷款金额（万元）";
        self.titleLabel?.font = XZClient.XZFont2(size: 15)
        self.contentView.addSubview(self.titleLabel!)
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(15)
        })
        
        self.bgTextFieldView = UIView()
        self.bgTextFieldView?.layer.borderWidth = 0.5
        self.bgTextFieldView?.layer.borderColor = XZSwiftColor.xzGlay50.cgColor
        self.bgTextFieldView?.layer.cornerRadius = 5
        self.contentView.addSubview(self.bgTextFieldView!)
        self.bgTextFieldView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-15)
            make.left.equalTo(self.contentView.snp.centerX).offset(20);
            make.height.equalTo(32);
        })
        
        self.summeryLabel = UILabel()
        self.summeryLabel?.text = "号"
        self.summeryLabel?.isHidden = true
        self.summeryLabel?.font = XZClient.XZFont2(size: 15)
        self.bgTextFieldView?.addSubview(self.summeryLabel!)
        self.summeryLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.bgTextFieldView!)
            make.right.equalTo(self.bgTextFieldView!).offset(-10)
        })
        
        self.textField = UITextField()
        self.textField?.keyboardType = .numberPad
        self.textField?.font = XZClient.XZFont2(size: 15)
        self.bgTextFieldView?.addSubview(self.textField!)
        self.textField?.snp.makeConstraints({ (make) in
            make.top.bottom.equalTo(self.bgTextFieldView!)
            make.right.equalTo(self.bgTextFieldView!).offset(-25)
            make.left.equalTo(self.bgTextFieldView!).offset(8);
        })
        
        let keyboard = XZNumberKeyBoard()
        keyboard.setInputView(self.textField!)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class TitleSwitchTableViewCell: UITableViewCell {

    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 16)
        return label
    }()
    
    var sevenSwitch:UISwitch = {
        let switchs = UISwitch()
        
        switchs.onTintColor = XZSwiftColor.topicListDateColor
        switchs.tintColor = XZSwiftColor.topicListDateColor
        switchs.thumbTintColor = XZSwiftColor.linksColor
        
        return switchs
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.setup();
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setup()->Void{
        self.backgroundColor = UIColor.white
        self.selectionStyle = .none

        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ (make) -> Void in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(sevenSwitch)
        sevenSwitch.snp.makeConstraints{ (make) -> Void in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(50);
            make.height.equalTo(30);
        }
        
    }
}
