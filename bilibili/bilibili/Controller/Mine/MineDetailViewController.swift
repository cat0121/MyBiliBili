//
//  MineDetailViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/21.
//  Copyright © 2016年 yan. All rights reserved.
//

//http://account.bilibili.com/api/myinfo/v2?access_key=c047fed0df3d42ac47e231e832ce4a53&appkey=27eb53fc9058f8c3&platform=ios&ts=1482289744&type=json&sign=2243d1b84ce3e0882a639a9dee555ba5
//更详细的信息：http://app.bilibili.com/x/v2/space?access_key=c047fed0df3d42ac47e231e832ce4a53&build=4040&device=phone&mobi_app=1&name=%E8%90%8C%E5%B0%8F%E7%8C%AB121&platform=ios&vmid=52052310

import UIKit

class MineDetailViewController: UIViewController {
    
    var mineDetailHelper: MineDetailViewHelper?
    var mineData: MineInfoModel?
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
        initHelper()
        loadData()

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBar.hidden = true
    }
    //MARK: -- event response
    func backClick(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(false)
    }
    func headerMore(sender: UIButton) {
        let favourite = FavouriteListViewController()
        favourite.favouriteList = mineData?.favourite
        self.navigationController?.pushViewController(favourite, animated: false)
    }
    func showMoreInfo(sender: UIButton) {
        let personInfo = PersonalInfoViewController()
        self.navigationController?.pushViewController(personInfo, animated: false)
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(headerView)
        self.headerView.addSubview(backBtn)
//        self.view.addSubview(scrollView)
        self.view.addSubview(infoView)
        self.view.addSubview(mineCollectionView)
    }
    func layoutPageSubviews() {
        headerView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(200)
        }
        backBtn.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(30)
            make.left.equalTo(self.view).offset(10)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
//        scrollView.snp_makeConstraints { (make) in
//            make.top.equalTo(self.view).offset(130-SCREEN_WIDTH*0.11)
//            make.left.equalTo(self.view).offset(0)
//            make.height.equalTo(SCREEN_HEIGHT)
//            make.width.equalTo(SCREEN_WIDTH)
//        }
        infoView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(130)
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT*0.21)
        }
        mineCollectionView.snp_makeConstraints { (make) in
            make.top.equalTo(infoView.snp_bottom).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
            make.width.equalTo(SCREEN_WIDTH)
        }
    }
    func drawRound() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRectMake(0, 200, 200, 200)
        shapeLayer.position = self.view.center
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        //设置线条宽度和颜色
        shapeLayer.lineWidth = 1.0
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        
        //创建出圆形的贝塞尔曲线
        let bezierPath = UIBezierPath(ovalInRect: CGRectMake(0, 200, 200, 200))
        //让贝赛尔曲线与CAShapeLayer产生联系
        shapeLayer.path = bezierPath.CGPath
        //添加并显示
        self.view.layer.addSublayer(shapeLayer)
        
    }
    func initHelper() {
        mineDetailHelper = MineDetailViewHelper()
        mineDetailHelper?.callBackDelegate = self
        mineDetailHelper?.mineViewController = self
        mineData = MineInfoModel()
    }
    func loadData() {
        mineDetailHelper?.mineModel?.name = infoView.personData.uname
        mineDetailHelper?.mineManager?.loadData()
    
    }
    
    //MARK: -- setter and getter
    var _headerView: UIImageView!
    var headerView: UIImageView {
        if _headerView == nil {
            _headerView = UIImageView()
            _headerView.userInteractionEnabled = true
            _headerView.image = UIImage(named: "headerView")
        }
        return _headerView
    }
    var _backBtn: UIButton!
    var backBtn: UIButton {
        if _backBtn == nil {
            _backBtn = UIButton(type: .Custom)
            _backBtn.setBackgroundImage(UIImage(named: "common_backShadow"), forState: .Normal)
            _backBtn.addTarget(self, action: #selector(MineDetailViewController.backClick(_:)), forControlEvents: .TouchUpInside)
        }
        return _backBtn
    }
//    var _scrollView: UIScrollView!
//    var scrollView: UIScrollView {
//        if _scrollView == nil {
//            _scrollView = UIScrollView()
//            _scrollView.backgroundColor = UIColor.clearColor()
//            _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,600)
//        }
//        return _scrollView
//    }
    var _infoView: PersonalInfoView!
    var infoView: PersonalInfoView {
        if _infoView == nil {
            _infoView = PersonalInfoView()
            _infoView.backgroundColor = UIColor.whiteColor()
//            _infoView.personalBtn.addTarget(self, action: #selector(<#T##@objc method#>), forControlEvents: <#T##UIControlEvents#>)
        }
        return _infoView
    }
    
    var _mineCollectionView: UICollectionView!
    var mineCollectionView: UICollectionView {
        if _mineCollectionView == nil {
            let layout = UICollectionViewFlowLayout()
            _mineCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
            _mineCollectionView.backgroundColor = YYBackgroundColor
            
            _mineCollectionView.delegate = self
            _mineCollectionView.dataSource = self
            
            _mineCollectionView.registerClass(FavouriteViewCell.self, forCellWithReuseIdentifier: "favouriteCell")
            _mineCollectionView.registerClass(SeasonViewCell.self, forCellWithReuseIdentifier: "seasonCell")
            _mineCollectionView.registerClass(TagViewCell.self, forCellWithReuseIdentifier: "tagCell")
            _mineCollectionView.registerClass(MineInfoHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "mineDHeader")
        }
        return _mineCollectionView
    }
}

extension MineDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            if mineData?.favourite?.item?.count > 0 && mineData?.favourite?.item?.count <= 3 {
                return (mineData?.favourite?.item?.count)!
            } else if mineData?.favourite?.item?.count > 3 {
                return 3
            }
        case 1:
            if mineData?.season?.item?.count > 0 && mineData?.season?.item?.count <= 3 {
                return (mineData?.season?.item?.count)!
            } else if mineData?.season?.item?.count > 3 {
                return 3
            }
        case 2:
            if mineData?.tag?.count > 0 && mineData?.tag?.count <= 3 {
                return (mineData?.tag?.count)!
            } else if mineData?.tag?.count > 3 {
                return 3
            }
        default:
            return 0
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("favouriteCell", forIndexPath: indexPath) as! FavouriteViewCell
            cell.favourite = (mineData?.favourite?.item?[indexPath.item])!
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("seasonCell", forIndexPath: indexPath) as! SeasonViewCell
            cell.seasonModel = (mineData?.season?.item?[indexPath.item])!
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("tagCell", forIndexPath: indexPath) as! TagViewCell
            cell.tagModel = (mineData?.tag![indexPath.item])!
            return cell
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSizeMake(SCREEN_WIDTH*0.33, SCREEN_WIDTH*0.33)
        case 1:
            return CGSizeMake(SCREEN_WIDTH*0.28, SCREEN_HEIGHT*0.236)
        case 2:
            return CGSizeMake(50, SCREEN_HEIGHT*0.04)
        default:
            return CGSizeMake(0, 0)
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 0, 10)
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "mineDHeader", forIndexPath: indexPath) as! MineInfoHeader
        if mineData?.tag != nil {
            switch indexPath.section {
            case 0:
                header.classifyLab.text = String.init(format: "我的收藏夹 %d", mineData!.favourite!.item!.count)
            case 1:
                header.classifyLab.text = String.init(format: "我的追番 %d", mineData!.season!.item!.count)
            case 2:
                header.classifyLab.text = String.init(format: "我关注的标签 %d", mineData!.tag!.count)
            default:
                break
            }
        }
        header.moreButton.addTarget(self, action: #selector(MineDetailViewController.headerMore(_:)), forControlEvents: .TouchUpInside)
        return header
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(SCREEN_WIDTH, 40)
    }
}

extension MineDetailViewController: MineDetailViewCallBackDelegate {
    func callBackSuccess() {
        mineData = mineDetailHelper?.mineModel
        mineCollectionView.reloadData()
    }
    func callBackFailure() {
        
    }
}