//
//  PartionRecommendBaseViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class PartionRecommendBaseViewController: UIViewController {
    
    var partionDataSource: CartoonRecommendModel?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubViews()
       
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(partionRecTableview)
    }
    func layoutPageSubViews() {
        partionRecTableview.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    //MARK: -- setter and getter
    var _partionRecTableview: UICollectionView!
    var partionRecTableview: UICollectionView {
        if _partionRecTableview == nil {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: SCREEN_WIDTH*0.47, height: SCREEN_HEIGHT*0.23)
            _partionRecTableview = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
            _partionRecTableview.backgroundColor = YYBackgroundColor
            //代理
            _partionRecTableview.delegate = self
            _partionRecTableview.dataSource = self
            
            //注册
            _partionRecTableview.registerClass(RecommendViewCell.self, forCellWithReuseIdentifier: "cartoonCell")
            _partionRecTableview.registerClass(RecommendViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "cartoonHeader")
        }
        return _partionRecTableview
    }
}

extension PartionRecommendBaseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if partionDataSource?.recommend?.count > 0 && partionDataSource?.new?.count > 0 && partionDataSource?.dynamic?.count > 0 {
            switch section {
            case 0:
                return (partionDataSource?.recommend?.count)!
            case 1:
                return (partionDataSource?.new?.count)!
            case 2:
                return (partionDataSource?.dynamic?.count)!
            default:
                break
            }
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cartoonCell", forIndexPath: indexPath) as! RecommendViewCell
        switch indexPath.section {
        case 0:
            cell.bodyModel = (partionDataSource?.recommend![indexPath.item])!
        case 1:
            cell.bodyModel = (partionDataSource?.new![indexPath.item])!
        case 2:
            cell.bodyModel = (partionDataSource?.dynamic![indexPath.item])!
        default:
            break
        }
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 5)
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "cartoonHeader", forIndexPath: indexPath) as! RecommendViewHeader
        switch indexPath.section {
        case 0:
            if partionDataSource?.banner?.count > 0 {
                header.bannerModelArr = (partionDataSource?.banner)!
            }
            header.leftImage.image = UIImage(named: "home_recommend")
            header.leftTitle.text = "热门推荐"
        case 1:
            header.leftImage.image = UIImage(named: "home_new_region")
            header.leftTitle.text = "最新投稿"
        case 2:
            header.leftImage.image = UIImage(named: "home_region_icon_1")
            header.leftTitle.text = "全区动态"
        default:
            break
        }
        
        return header
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT*0.23)
        } else {
            return CGSize(width: SCREEN_WIDTH, height: 40)
        }
    }
}

