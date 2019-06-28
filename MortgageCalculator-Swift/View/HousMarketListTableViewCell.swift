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
        imageView.style.preferredSize = CGSize(width: 115, height: 90)
        imageView.backgroundColor = XZSwiftColor.white
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let titleNode: ASTextNode = {
        let titleNode = ASTextNode()
        titleNode.maximumNumberOfLines = 0
        titleNode.style.maxWidth = ASDimensionMake(XZClient.ScreenWidth() - 10 - 115 - 25)
        return titleNode
    }()
    
    let sourceNode: ASTextNode = {
        let sourceNode = ASTextNode()
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
                                            justifyContent: .spaceBetween,
                                            alignItems: .stretch,
                                            children: [titleLayout,imageView])

        let titleinsetLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10), child: imageLayout)

        return titleinsetLayout
    }
    
    private var digItem:Newslist
    
    init(digItem:Newslist) {
        self.digItem = digItem
        super.init()
        self.automaticallyManagesSubnodes = true
        self.backgroundColor = UIColor.white
        
        
        if let titleStr = self.digItem.title {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 3
            let attrString = NSMutableAttributedString(string: titleStr,
                                                       attributes: [
                                                        NSAttributedString.Key.foregroundColor: XZSwiftColor.xzGlay50,
                                                        NSAttributedString.Key.paragraphStyle: style,
                                                        NSAttributedString.Key.font:  XZClient.XZFont(size: 16)])
            titleNode.attributedText = attrString
        }
        
        if var sourceStr = self.digItem.source {
            if(sourceStr.components(separatedBy: "腾讯").count > 1){
                sourceStr = sourceStr.replacingOccurrences(of:"腾讯", with: "")
            }
            let attrStrings = NSMutableAttributedString(string: sourceStr,
                                                        attributes: [
                                                            NSAttributedString.Key.foregroundColor: XZSwiftColor.xzGlay129,
                                                            NSAttributedString.Key.font:  XZClient.XZFont(size: 14)])
            sourceNode.attributedText = attrStrings
        }
        
        
        if let image = self.digItem.thumbnails {
            
            self.imageView.url = URL(string: image[0])
        }
  
    }
}
