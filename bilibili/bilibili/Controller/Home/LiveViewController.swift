//
//  LiveViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/8.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://live.bilibili.com/AppNewIndex/common?scale=2&device=phone&platform=ios
import UIKit
import SnapKit
import MJRefresh

class LiveViewController: UIViewController {
    
    var liveViewHelper: LiveViewHlper?
    var liveDataSource: LiveModel?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
        initHelper()
        liveViewHelper?.liveManager?.loadData()
    }
    //MARK: -- event response
//    func headerViewAction(tap: UITapGestureRecognizer) {
//        let banner = BannerDetailViewController()
//        banner.url = liveDataSource?.banner
//    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(liveCollection)
    }
    func layoutPageSubviews() {
        liveCollection.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: -55, right: 0))
            make.height.equalTo(SCREEN_HEIGHT)
        }
    }
    func initHelper() {
        liveViewHelper = LiveViewHlper()
        liveViewHelper?.callBackDelegate = self
        liveViewHelper?.liveViewController = self
    }
    
    //MARK: -- setter and getter
    var  _liveCollection: UICollectionView!
    var liveCollection: UICollectionView {
        if _liveCollection == nil {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSizeMake(SCREEN_WIDTH*0.47, SCREEN_HEIGHT*0.23)
            layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
            _liveCollection = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
            _liveCollection.backgroundColor = YYBackgroundColor
            //添加下拉刷新 （带有最后刷新的时间）
            let header = MJRefreshNormalHeader(refreshingBlock: {
                self.liveViewHelper?.liveManager?.loadData()
            })
            header.setTitle("下拉加载更多", forState: .Idle)
            header.beginRefreshing()
            _liveCollection.mj_header = header
            
            //设置代理
            _liveCollection.delegate = self
            _liveCollection.dataSource = self
            
            //注册
            _liveCollection.registerClass(LiveViewCell.self, forCellWithReuseIdentifier: "liveCell")
            _liveCollection.registerClass(LiveHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "liveHeader")
        }
        return _liveCollection
    }
}
extension LiveViewController: LiveViewCallBackDelegate {
    func callBackSuccess() {
        
        liveDataSource = liveViewHelper?.liveModel
        liveCollection.reloadData()
        liveCollection.mj_header.endRefreshing()
    }
    func callBackFailure() {
        
    }
}
extension LiveViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if liveDataSource != nil && liveDataSource!.partions!.count > 0 {
            return liveDataSource!.partions!.count
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if liveDataSource?.partions![section].partionsDetails?.count > 0 {
            return (liveDataSource?.partions![section].partionsDetails?.count)!
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("liveCell", forIndexPath: indexPath) as! LiveViewCell
        
        cell.pationsModel = (liveDataSource?.partions![indexPath.section].partionsDetails![indexPath.item])!

        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 7, 0, 5)
    }
    
    //headerView
    func  collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let header = liveCollection.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "liveHeader", forIndexPath: indexPath) as! LiveHeaderView
        if indexPath.section == 0 {
            header.bannerModelArr = liveDataSource!.banner!
//            //添加点击手势
//            let tap = UITapGestureRecognizer(target: self, action: #selector(LiveViewController.headerViewAction(_:)))
//            header.liveScrollView.addGestureRecognizer(tap)
        }
        header.liveDetailsModel = liveDataSource!.partions![indexPath.section]
        return header
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT*0.23)
        }
        return CGSize(width: SCREEN_WIDTH, height: 40)
    }
}