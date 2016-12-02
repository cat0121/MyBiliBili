//
//  DynamicViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//
//http://api.bilibili.com/search_recommend?_device=iphone&_hwid=27d487196f4b7df1&_ulv=10000&appkey=27eb53fc9058f8c3&appver=3970&build=3970&mid=52052310&platform=ios&recommend_type=upuser&ts=1480569537&type=json&sign=51e4ac992b9af788030380f1f907dbdf


import UIKit
import MJRefresh
import CSNetManager

class DynamicViewController: UIViewController {
    
    var dynamicDataSource: DynamicModel?
    var dynamicHelper: DynamicViewHelper?
    var page: Int = 1
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
        initHelper()
        
        dynamicHelper?.dynamicManager?.loadData()
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
    
    func initHelper() {
        dynamicHelper = DynamicViewHelper()
        dynamicHelper?.callBackDelegate = self
        dynamicHelper?.dynamicViewController = self
        
        dynamicDataSource = DynamicModel()
    }
    
    //MARK: -- setter and getter
    var _dynamicCollectionView: UICollectionView!
    var dynamicCollectionView: UICollectionView {
        if _dynamicCollectionView == nil {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSizeMake(SCREEN_WIDTH*0.47, SCREEN_HEIGHT*0.25)
            _dynamicCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
            _dynamicCollectionView.backgroundColor = UIColor.whiteColor()
            _dynamicCollectionView.delegate = self
            _dynamicCollectionView.dataSource = self
            
            //添加下拉刷新
            let header = MJRefreshNormalHeader(refreshingBlock: { 
                self.dynamicHelper?.dynamicManager?.loadData()
            })
            _dynamicCollectionView.mj_header = header
            let footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                self.dynamicHelper?.dynamicModel!.page = self.page
                self.dynamicHelper?.dynamicManager?.loadData()
                self.page += 1
            })
            _dynamicCollectionView.mj_footer = footer
            
            //注册
            _dynamicCollectionView.registerClass(DynamicViewCell.self, forCellWithReuseIdentifier: "dynamicCell")
            _dynamicCollectionView.registerClass(DynamicViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "dynamicHeader")
            _dynamicCollectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "dynamicFooter")
        }
        return _dynamicCollectionView
    }
}

extension DynamicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if dynamicDataSource?.videos?.count > 0 {
            return (dynamicDataSource?.videos?.count)!
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dynamicDataSource?.videos![section].video?.count > 0 {
            return 2
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("dynamicCell", forIndexPath: indexPath) as! DynamicViewCell
        if indexPath.item < 2 {
            cell.dynamicVideos = (dynamicDataSource?.videos![indexPath.section].video![indexPath.item])!
        }
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(6, 6, 6, 6)
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let reusableView = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "dynamicHeader", forIndexPath: indexPath) as! DynamicViewHeader
            header.dynamicModel = (dynamicDataSource?.videos![indexPath.section])!
            return header
        
        } else if kind == UICollectionElementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "dynamicFooter", forIndexPath: indexPath)
            footer.backgroundColor = YYBackgroundColor
            return footer
        }
        
        return reusableView
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(SCREEN_WIDTH, 40)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeMake(SCREEN_WIDTH, 8)
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
//        return UIColor.lightGrayColor().colorWithAlphaComponent(0.5)
//    }
}

extension DynamicViewController: DynamicViewCallBackDelegate {
    func callBackSuccess() {
        dynamicDataSource = dynamicHelper?.dynamicModel
        dynamicCollectionView.reloadData()
        
        if dynamicCollectionView.mj_header.state == .Refreshing {
            dynamicDataSource = dynamicHelper?.dynamicModel
            dynamicCollectionView.reloadData()
            dynamicCollectionView.mj_header.endRefreshing()
        } else if dynamicCollectionView.mj_footer.state == .Refreshing {
            for item in (dynamicHelper?.dynamicModel?.videos)! {
                dynamicDataSource?.videos?.append(item)
            }
            dynamicCollectionView.reloadData()
            dynamicCollectionView.mj_footer.endRefreshing()
        }
        
        
    }
    func callBackFailure() {
        
    }
}