//
//  FavouriteListViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/29.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class FavouriteListViewController: UIViewController {

    var favouriteList: FavouriteModel?
    //MARK: -- life cycle
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
        self.title = "我的收藏夹"
        self.navigationItem.leftBarButtonItem = leftBackBtn
        self.navigationController?.navigationBar.hidden = false
        
        self.view.addSubview(favouriteCollection)
    }
    func layoutPageSubview() {
        favouriteCollection.snp_makeConstraints { (make) in
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
    
    var _favouriteCollection: UICollectionView!
    var favouriteCollection: UICollectionView {
        if _favouriteCollection == nil {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSizeMake(SCREEN_WIDTH/2-10, SCREEN_WIDTH/2-10)
            _favouriteCollection = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
            _favouriteCollection.backgroundColor = UIColor.whiteColor()
            
            _favouriteCollection.delegate = self
            _favouriteCollection.dataSource = self
            
            _favouriteCollection.registerClass(FavouriteViewCell.self, forCellWithReuseIdentifier: "favListCell")
        }
        return _favouriteCollection
    }
}

extension FavouriteListViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favouriteList?.item?.count > 0 {
            return (favouriteList?.item?.count)!
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("favListCell", forIndexPath: indexPath) as! FavouriteViewCell
        cell.favourite = (favouriteList?.item![indexPath.item])!
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 5, 0, 5)
    }
}
