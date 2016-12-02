//
//  PartionViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/7.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://app.bilibili.com/x/v2/region?access_key=986a5e5c71e98920fe6bab0e791c2d39&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3940&device=phone&mobi_app=iphone&platform=ios&sign=cf44106fa1ce10d8213659fe872119d5&ts=1479115671

import UIKit

class PartionViewController: UIViewController {
    
    let partionImgArr = ["home_subregion_live","home_subregion_bangumi","home_subregion_1","home_subregion_3",
                         "home_subregion_129","home_subregion_4","home_subregion_36","home_region_icon_76",
                         "home_subregion_119","home_region_icon_155","home_region_icon_34","home_region_icon_19",
                         "home_subregion_23","home_subregion_11","home_region_icon_71"]
    var partionHelper: PartionViewHlper?
    var partionDataSource: [PartionModel]?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubViews()
        initHelper()
        
        partionHelper?.partionViewManager?.loadData()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = false
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(partionCollectionView)
    }
    func layoutPageSubViews() {
        partionCollectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            make.height.equalTo(SCREEN_HEIGHT)
        }
    }
    
    func initHelper() {
        partionHelper = PartionViewHlper()
        partionHelper?.callBackDelegate = self
        partionHelper?.partionController = self
        
    }
    
    //MARK: -- setter and getter
    var _partionCollectionView: UICollectionView!
    var partionCollectionView: UICollectionView {
        if _partionCollectionView == nil {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: SCREEN_WIDTH*0.3, height: SCREEN_HEIGHT*0.15)
            _partionCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
            _partionCollectionView.backgroundColor = YYBackgroundColor
            _partionCollectionView.delegate = self
            _partionCollectionView.dataSource = self
            
            //注册
            _partionCollectionView.registerClass(PartionViewCell.self, forCellWithReuseIdentifier: "partionCell")
            
        }
        return _partionCollectionView
    }
}


extension PartionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if partionDataSource?.count > 0 {
            return partionDataSource!.count
        }
        return 15
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("partionCell", forIndexPath: indexPath) as! PartionViewCell
        cell.partionImg.image = UIImage(named: partionImgArr[indexPath.item])
        if partionDataSource?.count > 0 {
            cell.partionModel = partionDataSource![indexPath.item]
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    //点击cell
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.item {
        case 0:
            self.tabBarController?.selectedIndex = 0
        case 1:
            let partionBangumi = PartionBangumiViewController()
            self.navigationController?.pushViewController(partionBangumi, animated: false)
        case 2:
            let partionCartoon = PartionCartoonViewController()
            self.navigationController?.pushViewController(partionCartoon, animated: false)
        case 3:
            let partionMusic = PartionMusicViewController()
            self.navigationController?.pushViewController(partionMusic, animated: false)
        default:
            break
        }
        
        
    }
}

extension PartionViewController: PartionViewCallBackDelegate {
    func callBackSuccess() {
    
        partionDataSource = partionHelper?.partionModel
        partionCollectionView.reloadData()
    }
    func callBackFailure() {
        
    }
}