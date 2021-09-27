//
//  RateTableViewCell.swift
//  MortgageCalculator-Swift
//
//  Created by HuaLaLa on 2021/9/22.
//  Copyright © 2021 com.longdai. All rights reserved.
//

import UIKit

class RateTableViewCell: UITableViewCell {
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 14)
        label.textAlignment = .center
        return label
    }()
    
    var rateOneLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 14)
        label.textAlignment = .center
        return label
    }()
    
    var rateTwoLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 14)
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.white;
        
        self.timeLabel.text = "2020-05-21"
        self.contentView.addSubview(self.timeLabel);
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.bottom.equalToSuperview()
            make.width.equalTo((XZClient.ScreenWidth()-20) / 3.00)
        }
        
        self.rateOneLabel.text = "3.45"
        self.contentView.addSubview(self.rateOneLabel);
        self.rateOneLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.bottom.equalToSuperview()
            make.width.equalTo((XZClient.ScreenWidth()-30) / 3.00)
        }
        
        self.rateTwoLabel.text = "4.56"
        self.contentView.addSubview(self.rateTwoLabel);
        self.rateTwoLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.top.bottom.equalToSuperview()
            make.width.equalTo((XZClient.ScreenWidth()-30) / 3.00)
        }
        
        
    }

}


class RateInstructionTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont(size: 15)
        return label
    }()
    
    var instructionLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont2(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    var linView:UIView = {
        let view = UIView()
        view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        return view
    }()
    
    var titleOneLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont(size: 15)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.white;
        self.clipsToBounds = true
        
        self.titleLabel.text = "重要消息"
        self.contentView.addSubview(self.titleLabel);
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalToSuperview().offset(15)
        }
        
        let str = "2019年10月28日，人民银行发布公告，要求自2020年1月1日起，各金融机构不得签订参考贷款基准利率定价的浮动利率贷款合同。自2020年3月1日起，金融机构应与存量浮动利率贷款客户就定价基准转换条款进行协商，把原合同约定的利率定价方式转换为以LPR为定价基准加点形成（加点可为负值），加点数值在合同剩余期限内固定不变；也可转换为固定利率。"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        paragraphStyle.firstLineHeadIndent = 30.0
        
        let attrStr = NSMutableAttributedString(string: str, attributes: [.paragraphStyle:paragraphStyle])
        
        instructionLabel.attributedText = attrStr
                
        self.contentView.addSubview(self.instructionLabel);
        self.instructionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(15)
        }
        
        self.contentView.addSubview(self.linView);
        self.linView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.instructionLabel.snp.bottom).offset(15)
            make.height.equalTo(10)
        }
        
        self.titleOneLabel.text = "最新贷款市场报价LPR（近6个月）"
        self.contentView.addSubview(self.titleOneLabel);
        self.titleOneLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self.linView.snp.bottom).offset(15)
        }
    
    }

}

class RateOldTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = XZClient.XZFont(size: 15)
        return label
    }()
    
    var linView:UIView = {
        let view = UIView()
        view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.white;
        self.clipsToBounds = true
        
        self.contentView.addSubview(self.linView);
        self.linView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(10)
        }
        
        self.titleLabel.text = "最新房贷基准利率"
        self.contentView.addSubview(self.titleLabel);
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self.linView.snp.bottom).offset(15)
        }
    
    }

}
