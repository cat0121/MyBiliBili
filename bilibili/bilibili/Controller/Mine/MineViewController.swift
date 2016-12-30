//
//  MineViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {
    //等级：misc_level_colorfulLv%d
    //个人中心
    let mineCenter = ["mine_download","mine_history","mine_favourite","mine_follow","mine_pocketcenter","mine_vip_icon","mine_gamecenter","mine_theme","mine_bigvip_icon"]
    let centerTitle = ["离线缓存","历史记录","我的收藏","我的关注","我的钱包","会员积分","游戏中心","主题选择","大会员"]
    //我的消息
    let mineMessage = ["mine_answerMessage","mine_shakeMe","mine_gotPrise","mine_privateMessage","mine_systemNotification"]
    let messageTitle = ["回复我的","@我","收到的赞","私信","系统通知"]
    var mineViewHelper: MineViewHelper?
    var mineData: MineViewModel?

    //MARK: --   life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
        initHelper()
        loadData()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        self.navigationController?.navigationBar.hidden = true
    }
    
    //MARK: -- event response
    func moreInfo(sender: UIButton) {
        let mineDetail = MineDetailViewController()
        mineDetail.infoView.personData = self.mineData!
        self.navigationController?.pushViewController(mineDetail, animated: false)
    }
    //MARK: -- private method
    func initBaseLayout() {
        
        self.view.addSubview(headerView)
//        self.addBezier(headerView)
        self.headerView.addSubview(avatarBackImg)
        self.avatarBackImg.addSubview(avatarImg)
        self.headerView.addSubview(avatarName)
        self.headerView.addSubview(levelImg)
        self.headerView.addSubview(sexImg)
        self.headerView.addSubview(vipImg)
        self.headerView.addSubview(coinLab)
        self.headerView.addSubview(moreInfoBtn)
        self.headerView.addSubview(settingBtn)
        self.view.addSubview(mineCollection)
    }
    func layoutPageSubviews() {
        headerView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT*0.225)
        }
        avatarBackImg.snp_makeConstraints { (make) in
            make.top.equalTo(headerView.snp_top).offset(50)
            make.left.equalTo(headerView.snp_left).offset(10)
            make.width.equalTo(SCREEN_WIDTH*0.245)
            make.height.equalTo(SCREEN_WIDTH*0.245)
        }
        avatarImg.snp_makeConstraints { (make) in
            make.top.equalTo(avatarBackImg.snp_top).offset(18)
            make.bottom.equalTo(avatarBackImg.snp_bottom).offset(-18)
            make.left.equalTo(avatarBackImg.snp_left).offset(18)
            make.right.equalTo(avatarBackImg.snp_right).offset(-18)
        }
        avatarName.snp_makeConstraints { (make) in
            make.top.equalTo(headerView.snp_top).offset(60)
            make.left.equalTo(avatarBackImg.snp_right).offset(8)
            make.height.equalTo(20)
            make.width.equalTo(80)
        }
        levelImg.snp_makeConstraints { (make) in
            make.top.equalTo(headerView.snp_top).offset(65)
            make.left.equalTo(avatarName.snp_right).offset(3)
            make.height.equalTo(12)
            make.width.equalTo(25)
        }
        sexImg.snp_makeConstraints { (make) in
            make.top.equalTo(headerView.snp_top).offset(64)
            make.left.equalTo(levelImg.snp_right).offset(3)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        vipImg.snp_makeConstraints { (make) in
            make.top.equalTo(avatarName.snp_bottom).offset(5)
            make.left.equalTo(avatarBackImg.snp_right).offset(8)
            make.height.equalTo(15)
            make.width.equalTo(45)
        }
        coinLab.snp_makeConstraints { (make) in
            make.top.equalTo(vipImg.snp_bottom).offset(5)
            make.left.equalTo(avatarBackImg.snp_right).offset(8)
            make.height.equalTo(15)
        }
        moreInfoBtn.snp_makeConstraints { (make) in
            make.right.equalTo(headerView.snp_right).offset(-10)
            make.top.equalTo(headerView.snp_top).offset(85)
            make.height.equalTo(17)
            make.width.equalTo(12)
        }
        settingBtn.snp_makeConstraints { (make) in
            make.right.equalTo(headerView.snp_right).offset(-13)
            make.top.equalTo(headerView.snp_top).offset(30)
            make.height.equalTo(23)
            make.width.equalTo(23)
        }
        mineCollection.snp_makeConstraints { (make) in
            make.top.equalTo(headerView.snp_bottom).offset(0)
            make.bottom.equalTo(self.view).offset(-55)
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(SCREEN_WIDTH)
        }
    }
    func initHelper() {
        mineViewHelper = MineViewHelper()
        mineViewHelper?.callBackDelegate = self
        mineViewHelper?.mineViewController = self
    }
    func loadData() {
        mineViewHelper?.mineManager?.loadData()
    }
    func reloadMineData() {
        avatarName.text = mineData?.uname
        coinLab.text = String.init(format: "硬币：%0.1f", mineData!.coins!)
        avatarImg.sd_setImageWithURL(NSURL(string: mineData!.face!) ,placeholderImage: UIImage(named: "default_img"))
        let level = String.init(format: "misc_level_colorfulLv%d", mineData!.current_level!)
        levelImg.image = UIImage(named: level)
        if mineData?.sex == 1 {
            sexImg.image = UIImage(named: "boy_icon_normal")
        } else if mineData?.sex == 2 {
            sexImg.image = UIImage(named: "mine_gril_icon_normal")
        } else {
            
        }
    }
    
    //给headerView添加贝塞尔曲线
    func addBezier(view: UIView) {
        let bezierPath = UIBezierPath()
        //设置红色画笔线
        let strokeColor = UIColor.redColor()
        //填充颜色
        strokeColor.set()
        //贝塞尔曲线进行画笔填充
        bezierPath.stroke()
        //创建一个点
        bezierPath.moveToPoint(CGPointMake(0,0))
        //加条线，从点移动到另一个点
        bezierPath.addLineToPoint(CGPointMake(0, view.frame.width-10))
        bezierPath.addLineToPoint(CGPointMake(view.frame.width-10, view.frame.height))
        bezierPath.addLineToPoint(CGPointMake(0, view.frame.height))
        //关闭贝塞尔曲线
        bezierPath.closePath()
 
        let layer = CAShapeLayer()
        layer.path = bezierPath.CGPath
        view.layer.mask = layer
    }
    
    //MARK: -- setter and getter
    var _headerView: UIView!
    var headerView: UIView {
        if _headerView == nil {
            _headerView = UIView()
            _headerView.backgroundColor = YYMain_Color
//            _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.225)
        }
        return _headerView
    }
    var _avatarBackImg: UIImageView!
    var avatarBackImg: UIImageView {
        if _avatarBackImg == nil {
            _avatarBackImg = UIImageView()
            _avatarBackImg.image = UIImage(named: "mine_bg_avatar")
        }
        return _avatarBackImg
    }
    var _avatarImg: UIImageView!
    var avatarImg: UIImageView {
        if _avatarImg == nil {
            _avatarImg = UIImageView()
            _avatarImg.layer.cornerRadius = 26.5
            _avatarImg.layer.masksToBounds = true
        }
        return _avatarImg
    }
    var _avatarName: UILabel!
    var avatarName: UILabel {
        if _avatarName == nil {
            _avatarName = UILabel()
            _avatarName.textColor = UIColor.whiteColor()
            _avatarName.font = UIFont.systemFontOfSize(17)
        }
        return _avatarName
    }
    var _levelImg: UIImageView!
    var levelImg: UIImageView{
        if _levelImg == nil {
            _levelImg = UIImageView()
        }
        return _levelImg
    }
    var _sexImg: UIImageView!
    var sexImg: UIImageView {
        if _sexImg == nil {
            _sexImg = UIImageView()
        }
        return _sexImg
    }
    var _vipImg: UIImageView!
    var vipImg: UIImageView {
        if _vipImg == nil {
            _vipImg = UIImageView()
            _vipImg.image = UIImage(named: "mine_vip")
        }
        return _vipImg
    }
    var _coinLab: UILabel!
    var coinLab: UILabel {
        if _coinLab == nil {
            _coinLab = UILabel()
            _coinLab.textColor = UIColor.whiteColor()
            _coinLab.font = UIFont.systemFontOfSize(12)
        }
        return _coinLab
    }
    var _moreInfoBtn: UIButton!
    var moreInfoBtn: UIButton {
        if _moreInfoBtn == nil {
            _moreInfoBtn = UIButton(type: .Custom)
            _moreInfoBtn.setBackgroundImage(UIImage(named: "mine_more"), forState: .Normal)
            _moreInfoBtn.addTarget(self, action: #selector(MineViewController.moreInfo(_:)), forControlEvents: .TouchUpInside)
        }
        return _moreInfoBtn
    }
    var _settingBtn: UIButton!
    var settingBtn: UIButton {
        if _settingBtn == nil {
            _settingBtn = UIButton(type: .Custom)
            _settingBtn.setBackgroundImage(UIImage(named: "mine_setting"), forState: .Normal)
        }
        return _settingBtn
    }
    var _mineCollection: UICollectionView!
    var mineCollection: UICollectionView {
        if _mineCollection == nil {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSizeMake(SCREEN_WIDTH/4.2-5, SCREEN_WIDTH/4.2-5)
            _mineCollection = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
            _mineCollection.backgroundColor = UIColor.whiteColor()
            
            _mineCollection.delegate = self
            _mineCollection.dataSource = self
            
            _mineCollection.registerClass(MineViewCell.self, forCellWithReuseIdentifier: "mineCell")
            _mineCollection.registerClass(MineViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "mineHeader")
            _mineCollection.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "mineFooter")
        }
        return _mineCollection
    }
}

extension MineViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return mineCenter.count
        }
        if section == 1 {
            return mineMessage.count
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("mineCell", forIndexPath: indexPath) as! MineViewCell
        if indexPath.section == 0 {
            cell.infoImg.image = UIImage(named: mineCenter[indexPath.row])
            cell.infoTitle.text = centerTitle[indexPath.row]
        }
        if indexPath.section == 1 {
            cell.infoImg.image = UIImage(named: mineMessage[indexPath.row])
            cell.infoTitle.text = messageTitle[indexPath.row]
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let reusableView = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "mineHeader", forIndexPath: indexPath) as! MineViewHeader
            if indexPath.section == 0 {
                header.sectionLabel.text = "个人中心"
            } else {
                header.sectionLabel.text = "我的消息"
            }
            return header
            
        } else if kind == UICollectionElementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "mineFooter", forIndexPath: indexPath)
            footer.backgroundColor = YYBackgroundColor
            return footer
        }
        
        return reusableView
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(SCREEN_WIDTH, 44)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeMake(SCREEN_WIDTH, 10)
        }
        return CGSizeMake(0, 0)
    }
}

extension MineViewController: MineViewCallBackDelegate {
    func callBackSuccess() {
        mineData = mineViewHelper?.mineModel
        self.reloadMineData()
    }
    func callBackFailure() {
        
    }
}