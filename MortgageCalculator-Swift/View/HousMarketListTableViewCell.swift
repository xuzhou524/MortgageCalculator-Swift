//
//  HousMarketListTableViewCell.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/15.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HousMarketListTableViewCell: ASCellNode {

    let imageView: ASNetworkImageNode = {
        let imageView = ASNetworkImageNode()
        imageView.style.preferredSize = CGSize(width: 100, height: 100)
        imageView.backgroundColor = XZSwiftColor.orange
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleNode: ASTextNode = {
        let titleNode = ASTextNode()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3
        titleNode.maximumNumberOfLines = 0
        titleNode.style.maxWidth = ASDimensionMake(XZClient.ScreenWidth() - 10 - 100 - 25)
        let attrString = NSMutableAttributedString(string: "腾讯新闻腾讯新闻腾讯新闻腾讯新闻腾讯新闻腾讯新闻",
                                                   attributes: [
                                                    NSForegroundColorAttributeName: XZSwiftColor.white,
                                                    NSParagraphStyleAttributeName: style,
                                                    NSFontAttributeName:  XZClient.XZFont(size: 16)])
        titleNode.attributedText = attrString
        return titleNode
    }()
    
    let sourceNode: ASTextNode = {
        let sourceNode = ASTextNode()
        let attrString = NSMutableAttributedString(string: "来源：腾讯新闻",
                                                   attributes: [
                                                    NSForegroundColorAttributeName: XZSwiftColor.white,
                                                    NSFontAttributeName:  XZClient.XZFont(size: 14)])
        sourceNode.attributedText = attrString
        return sourceNode
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let titleLayout = ASStackLayoutSpec(direction: .vertical,
                                     spacing: 0,
                                     justifyContent: .spaceBetween,
                                     alignItems: .stretch,
                                     children: [titleNode,sourceNode])
        
        let imageLayout = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 15,
                                            justifyContent: .start,
                                            alignItems: .stretch,
                                            children: [titleLayout,imageView])

        let titleinsetLayout = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(8, 10, 8, 10), child: imageLayout)

        return titleinsetLayout
    }
    
    private var digItem:String
    
    init(digItem:String) {
        self.digItem = digItem
        super.init()
        self.automaticallyManagesSubnodes = true
        self.backgroundColor = UIColor.gray
    }
}
