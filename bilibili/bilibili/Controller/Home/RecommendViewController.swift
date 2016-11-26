//
//  RecommendViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/8.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit
import MJRefresh

class RecommendViewController: UIViewController {
    
    var recommendViewHelper: RecommendViewHepler?
    //数据源
    var recDataSource: [RecDetailsModel]?
    let sectionImageArr: [String] = ["home_recommend","home_subregion_live","home_subregion_bangumi","home_subregion_1","home_subregion_3","home_subregion_129","home_subregion_4","home_subregion_119","home_subregion_36","home_subregion_155","home_region_icon_76","home_subregion_5","home_region_icon_30","home_region_icon_19","home_subregion_11","home_subregion_23"]
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化界面
        initBaseLayout()
        layoutPageSubViews()
        initHelper()
        recommendViewHelper?.recManager?.loadData()
        
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(recommendCollection)
    }
    func layoutPageSubViews() {
        recommendCollection.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, -55, 0))
            make.height.equalTo(SCREEN_HEIGHT)
        }
    }
    func initHelper() {
        recommendViewHelper = RecommendViewHepler()
        recommendViewHelper?.recommendViewController = self
        recommendViewHelper?.callBackDelegate = self
        
        recDataSource = [RecDetailsModel]()
    }
    
    //MARK: -- setter and getter
    var _recommendCollection: UICollectionView!
    var recommendCollection: UICollectionView {
        if _recommendCollection == nil {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSizeMake(SCREEN_WIDTH*0.47, SCREEN_HEIGHT*0.23)
            layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
            _recommendCollection = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
            _recommendCollection.backgroundColor = UIColor.whiteColor()
            //添加下拉刷新 （带有最后刷新的时间）
            let header = MJRefreshNormalHeader(refreshingBlock: {
                self.recommendViewHelper?.recManager?.loadData()
            })
            header.beginRefreshing()
            _recommendCollection.mj_header = header
            
            //设置代理
            _recommendCollection.delegate = self
            _recommendCollection.dataSource = self
            
            //注册
            _recommendCollection.registerClass(RecommendViewCell.self, forCellWithReuseIdentifier: "RecCell")
            _recommendCollection.registerClass(RecommendViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "recHeader")
            _recommendCollection.registerClass(RecommendViewFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "recFooter")
            
        }
        return _recommendCollection
    }
}

//MARK: -- UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension RecommendViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if recDataSource?.count > 0 {
            return recDataSource!.count
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if recDataSource![section].body?.count > 0 {
            return recDataSource![section].body!.count
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecCell", forIndexPath: indexPath) as! RecommendViewCell
        if recDataSource?.count > 0 {
            let bodyModel = recDataSource![indexPath.section].body
            cell.bodyModel = bodyModel![indexPath.item]
        }
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 7, 0, 5)
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reusableView = UICollectionReusableView()
        switch kind {
        //头视图
        case UICollectionElementKindSectionHeader:
            var header = RecommendViewHeader()
            header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "recHeader", forIndexPath: indexPath) as! RecommendViewHeader
            if indexPath.section == 0 {
                header.bannerModelArr = recDataSource![indexPath.section].banner!
            }
            header.recDetailsModel = recDataSource![indexPath.section]
            header.leftImage.image = UIImage(named: sectionImageArr[indexPath.section])
            reusableView = header
        
        //脚视图
        case UICollectionElementKindSectionFooter:
            var footer = RecommendViewFooter()
            footer = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "recFooter", forIndexPath: indexPath) as! RecommendViewFooter
            footer.recImage.sd_setImageWithURL(NSURL(string: recDataSource![indexPath.section].banner![0].bannerImage!))
            reusableView = footer
        default:
             break
        }
        return reusableView
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT*0.23)
        } else {
            return CGSize(width: SCREEN_WIDTH, height: 40)
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeZero
        } else {
            if recDataSource![section].banner!.count > 0 {
                return CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT*0.18)
            }
            return CGSizeZero
        }
    }
}
//MARK: -- RecommendViewCallBackDelegate
extension RecommendViewController: RecommendViewCallBackDelegate {
    func callBackSuccess() {
        
        recDataSource = recommendViewHelper?.recModel?.recDetails
        recommendCollection.reloadData()
        recommendCollection.mj_header.endRefreshing()
    }
    func callBackFailure() {
        
    }
}