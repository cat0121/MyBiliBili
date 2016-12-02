//
//  BangumiViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/8.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://bangumi.bilibili.com/api/app_index_page_v4?build=3940&device=phone&mobi_app=iphone&platform=ios

import UIKit
import MJRefresh

class BangumiViewController: UIViewController {
    
    var bangumiHelper: BangumiViewHelper?
    var bangumiDataSource: BangumiModel?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initBaseLayout()
        layoutPageSubViews()
        initHelper()
        
        bangumiHelper?.bangumiManager?.loadData()
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(bangumiCollection)
    }
    func layoutPageSubViews() {
        bangumiCollection.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: -55, right: 0))
            make.height.equalTo(SCREEN_HEIGHT)
        }
    }
    func initHelper() {
        bangumiHelper = BangumiViewHelper()
        bangumiHelper?.callBackDelegate = self
        bangumiHelper?.bangumiController = self
    }
    
    //MARK: -- setter and getter
    var _bangumiCollection: UICollectionView!
    var bangumiCollection: UICollectionView {
        if _bangumiCollection == nil {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSizeMake(SCREEN_WIDTH*0.29, SCREEN_HEIGHT*0.31)
            _bangumiCollection = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
            _bangumiCollection.backgroundColor = YYBackgroundColor
            //添加下拉刷新 （带有最后刷新的时间）
            let header = MJRefreshNormalHeader(refreshingBlock: {
                self.bangumiHelper?.bangumiManager?.loadData()
            })
            header.beginRefreshing()
            _bangumiCollection.mj_header = header
            
            //设置代理
            _bangumiCollection.delegate = self
            _bangumiCollection.dataSource = self
            
            //注册
            _bangumiCollection.registerClass(BangumiViewCell.self, forCellWithReuseIdentifier: "bangumiCell")
            _bangumiCollection.registerClass(BangumiViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "bangumiHeader")
        }
        return _bangumiCollection
    }
}

extension BangumiViewController: BangumiViewCallBackDelagate {
    func callBackSuccess() {
    
        bangumiDataSource = bangumiHelper?.bangumiModel
        bangumiCollection.reloadData()
        bangumiCollection.mj_header.endRefreshing()
    }
    func callBackFailure() {
        
    }
}
extension BangumiViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 && bangumiDataSource?.bangumiFirstModel?.count > 0{
            return (bangumiDataSource?.bangumiFirstModel?.count)!
        } else {
            if bangumiDataSource?.bangumiSecondModel?.bangumiSecondDeatils?.count > 0 {
                return (bangumiDataSource?.bangumiSecondModel?.bangumiSecondDeatils?.count)!
            }
            return 0
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("bangumiCell", forIndexPath: indexPath) as! BangumiViewCell
        switch indexPath.section {
        case 0:
            cell.firstModel = (bangumiDataSource?.bangumiFirstModel![indexPath.item])!
        case 1:
            cell.secondModel = (bangumiDataSource?.bangumiSecondModel?.bangumiSecondDeatils![indexPath.item])!
        default:
            break
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
    }
    
    //Header
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var header = BangumiViewHeader()
        header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "bangumiHeader", forIndexPath: indexPath) as! BangumiViewHeader
        if bangumiDataSource?.admodel?.banners?.count>0 && bangumiDataSource?.admodel?.bodys?.count>0{
            if indexPath.section == 0 {
                header.bannerArr = (bangumiDataSource?.admodel?.banners)!
            } else if indexPath.section == 1 {
                header.bodyArr = (bangumiDataSource?.admodel?.bodys)!
            }
        }
        
        return header
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT*0.45)
        } else if section == 1 {
            return CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT*0.23)
        } else if section == 2 {
            return CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT*0.06)
        }
        return CGSize(width: 0, height: 0)
    }
}