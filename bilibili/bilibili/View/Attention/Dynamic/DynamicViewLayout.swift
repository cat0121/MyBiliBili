//
//  DynamicViewLayout.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/25.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import UIKit

protocol  YYCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor
}

extension YYCollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        return UIColor.clearColor()
    }
}

class DynamicViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var backgroundColor = UIColor.clearColor()
}

class YYCollectionReusableView: UICollectionReusableView {
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        guard let attr = layoutAttributes as? DynamicViewLayoutAttributes
            else {
                return
        }
        self.backgroundColor = attr.backgroundColor
    }
}

class YYCollectionViewFlowLayout: UICollectionViewFlowLayout {
    private var decorationViewAttrs: [UICollectionViewLayoutAttributes] = []
    override func prepareLayout() {
        super.prepareLayout()
        
        guard let numberOfSections = self.collectionView?.numberOfSections(),
            let delegate = self.collectionView?.delegate as? YYCollectionViewDelegateFlowLayout
            else {
                return
        }
        
        //注册
        self.registerClass(YYCollectionReusableView.classForCoder(), forDecorationViewOfKind: "decoration")
        self.decorationViewAttrs.removeAll()
        for section in 0..<numberOfSections {
            guard let numberOfItems = self.collectionView?.numberOfItemsInSection(section),
                let firstItem = self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: section)),
                let lastItem = self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: numberOfItems - 1, inSection: section))
                else {
                    continue
            }
            
            var sectionInset = self.sectionInset
            if let inset = delegate.collectionView!(self.collectionView!, layout: self, insetForSectionAtIndex: section) as? UIEdgeInsets {
                sectionInset = inset
            }
            var sectionFrame = firstItem.frame.union(lastItem.frame)
            sectionFrame.origin.x -= sectionInset.left
            sectionFrame.origin.y -= sectionInset.top
            
            if self.scrollDirection == .Horizontal {
                sectionFrame.size.width += sectionInset.left + sectionInset.right
                sectionFrame.size.height = self.collectionView!.frame.height
            } else {
                sectionFrame.size.width = self.collectionView!.frame.width
                sectionFrame.size.height += sectionInset.top + sectionInset.bottom
            }
            
            //定义
            let attr = DynamicViewLayoutAttributes(forDecorationViewOfKind: "decoration", withIndexPath: NSIndexPath(forItem: 0, inSection: section))
            attr.frame = sectionFrame
            attr.zIndex = -1
            attr.backgroundColor = delegate.collectionView(self.collectionView!, layout: self, backgroundColorForSectionAt: section)
            self.decorationViewAttrs.append(attr)
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = super.layoutAttributesForElementsInRect(rect)
        for attr in self.decorationViewAttrs {
            if rect.intersects(attr.frame) {
                // 3、返回
                attrs?.append(attr)
            }
        }
        return attrs
    }
    
}