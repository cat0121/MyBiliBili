//
//  DynamicViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class DynamicViewController: UIViewController {
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(dynamicCollectionView)
    }
    func layoutPageSubviews() {
        dynamicCollectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    //MARK: -- setter and getter
    var _dynamicCollectionView: UICollectionView!
    var dynamicCollectionView: UICollectionView {
        if _dynamicCollectionView == nil {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSizeMake(SCREEN_WIDTH*0.47, SCREEN_HEIGHT*0.23)
            _dynamicCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
            _dynamicCollectionView.backgroundColor = UIColor.whiteColor()
            _dynamicCollectionView.delegate = self
            _dynamicCollectionView.dataSource = self
            
            //注册
            _dynamicCollectionView.registerClass(DynamicViewCell.self, forCellWithReuseIdentifier: "dynamicCell")
            _dynamicCollectionView.registerClass(DynamicViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "dynamicHeader")
        }
        return _dynamicCollectionView
    }
}

extension DynamicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 10
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("dynamicCell", forIndexPath: indexPath) as! DynamicViewCell
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(6, 6, 6, 6)
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "dynamicHeader", forIndexPath: indexPath) as! DynamicViewHeader
        
        return header
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(SCREEN_WIDTH, 40)
    }
}