//
//  UITableView+FINAutomaticHeightCell.swift
//  V2ex-Swift
//
//  Created by huangfeng on 1/12/16.
//  Copyright © 2016 Fin. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}

extension UITableView {

    public func fin_heightForCellWithIdentifier<T: UITableViewCell>(_ identifier: String, configuration: ((_ cell: T) -> Void)?) -> CGFloat {
        if identifier.count <= 0 {
            return 0
        }
        
        let cell = self.fin_templateCellForReuseIdentifier(identifier)
        cell.prepareForReuse()
        
        if configuration != nil {
            configuration!(cell as! T)
        }
        
//        cell.setNeedsUpdateConstraints();
//        cell.updateConstraintsIfNeeded();
//        self.setNeedsLayout();
//        self.layoutIfNeeded();
        
        var fittingSize = cell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if self.separatorStyle != .none {
            fittingSize.height += 1.0 / UIScreen.main.scale
        }
        return fittingSize.height
    }
    
    
    fileprivate func fin_templateCellForReuseIdentifier(_ identifier: String) -> UITableViewCell {
        assert(identifier.count > 0, "Expect a valid identifier - \(identifier)")
        if self.fin_templateCellsByIdentifiers == nil {
            self.fin_templateCellsByIdentifiers = [:]
        }
        var templateCell = self.fin_templateCellsByIdentifiers?[identifier] as? UITableViewCell
        if templateCell == nil {
            templateCell = self.dequeueReusableCell(withIdentifier: identifier)
            assert(templateCell != nil, "Cell must be registered to table view for identifier - \(identifier)")
            templateCell?.contentView.translatesAutoresizingMaskIntoConstraints = false
            self.fin_templateCellsByIdentifiers?[identifier] = templateCell
        }
        
        return templateCell!
    }
    
    public func fin_heightForCellWithIdentifier<T: UITableViewCell>(_ identifier: T.Type, indexPath: IndexPath, configuration: ((_ cell: T) -> Void)?) -> CGFloat {
        let identifierStr = "\(identifier)";
        if identifierStr.count == 0 {
            return 0
        }
        
//         Hit cache
        if self.fin_hasCachedHeightAtIndexPath(indexPath) {
            let height: CGFloat = self.fin_indexPathHeightCache![(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
//            NSLog("hit cache by indexPath:[\(indexPath.section),\(indexPath.row)] -> \(height)");
            return height
        }
        
        let height = self.fin_heightForCellWithIdentifier(identifierStr, configuration: configuration)
        self.fin_indexPathHeightCache![(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row] = height
//        NSLog("cached by indexPath:[\(indexPath.section),\(indexPath.row)] --> \(height)")
        
        return height
    }
    
    fileprivate struct AssociatedKey {
        static var CellsIdentifier = "me.fin.cellsIdentifier"
        static var HeightsCacheIdentifier = "me.fin.heightsCacheIdentifier"
        static var finHeightCacheAbsendValue = CGFloat(-1);
    }

    fileprivate func fin_hasCachedHeightAtIndexPath(_ indexPath:IndexPath) -> Bool {
        self.fin_buildHeightCachesAtIndexPathsIfNeeded([indexPath]);
        let height = self.fin_indexPathHeightCache![(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
        return height >= 0;
    }
    
    fileprivate func fin_buildHeightCachesAtIndexPathsIfNeeded(_ indexPaths:Array<IndexPath>) -> Void {
        if indexPaths.count <= 0 {
            return ;
        }
        
        if self.fin_indexPathHeightCache == nil {
            self.fin_indexPathHeightCache = [];
        }
        
        for indexPath in indexPaths {
            let cacheSectionCount = self.fin_indexPathHeightCache!.count;
            if  (indexPath as NSIndexPath).section >= cacheSectionCount {
                for i in cacheSectionCount...(indexPath as NSIndexPath).section {
                    if i >= self.fin_indexPathHeightCache?.count {
                        self.fin_indexPathHeightCache!.append([])
                    }
                }
            }
            
            let cacheCount = self.fin_indexPathHeightCache![(indexPath as NSIndexPath).section].count;
            if (indexPath as NSIndexPath).row >= cacheCount {
                for i in cacheCount...(indexPath as NSIndexPath).row {
                    if i >= self.fin_indexPathHeightCache![(indexPath as NSIndexPath).section].count {
                        self.fin_indexPathHeightCache![(indexPath as NSIndexPath).section].append(AssociatedKey.finHeightCacheAbsendValue);
                    }
                }
            }
        }
        
    }
    
    fileprivate var fin_templateCellsByIdentifiers: [String : AnyObject]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.CellsIdentifier) as? [String : AnyObject]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.CellsIdentifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    fileprivate var fin_indexPathHeightCache: [ [CGFloat] ]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.HeightsCacheIdentifier) as? [[CGFloat]]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.HeightsCacheIdentifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func fin_reloadData(){
        self.fin_indexPathHeightCache = [[]];
        self.reloadData();
    }

}
