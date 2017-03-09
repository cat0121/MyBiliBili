//
//  SeasonListViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/29.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class SeasonListViewController: UIViewController {

    var seasonListData: MineSeasonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubview()
    }

    //MARK: -- event method
    func backClick(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.title = "我的追番"
        self.navigationItem.leftBarButtonItem = leftBackBtn
        self.navigationController?.navigationBar.hidden = false
        
        self.view.addSubview(seasonCollection)
    }
    func layoutPageSubview() {
        seasonCollection.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    //MARK: -- setter and getter
    var _leftBackBtn:UIBarButtonItem!
    var leftBackBtn:UIBarButtonItem{
        if _leftBackBtn == nil{
            _leftBackBtn = UIBarButtonItem(image: UIImage(named: "fullplayer_icon_back"), style: .Plain, target: self, action: #selector(FavouriteListViewController.backClick(_:)))
            _leftBackBtn.tintColor = UIColor.whiteColor()
            
        }
        return _leftBackBtn
    }
    
    var _seasonCollection: UICollectionView!
    var seasonCollection: UICollectionView {
        if _seasonCollection == nil {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSizeMake(SCREEN_WIDTH*0.30, SCREEN_HEIGHT*0.236)
            _seasonCollection = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
            _seasonCollection.backgroundColor = UIColor.whiteColor()
            
            _seasonCollection.delegate = self
            _seasonCollection.dataSource = self
            
            _seasonCollection.registerClass(SeasonViewCell.self, forCellWithReuseIdentifier: "seaListCell")
        }
        return _seasonCollection
    }
}

extension SeasonListViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if seasonListData?.item?.count > 0 {
            return (seasonListData?.item?.count)!
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("seaListCell", forIndexPath: indexPath) as! SeasonViewCell
        cell.seasonModel = (seasonListData?.item![indexPath.item])!
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 5, 5, 8)
    }
}
