//
//  BangumiViewHeader.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/16.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import SDCycleScrollView

class BangumiViewHeader: UICollectionReusableView, SDCycleScrollViewDelegate {
    
    var recScrollHeight: CGFloat!
    var imageUrlArr = [String]()
    let partionImg = ["home_region_icon_33","home_region_icon_32","home_region_icon_153","home_region_icon_152"]
    let partionName = ["连载动画","完结动画","国产动画","官方延伸"]
    let bangumiImg = ["home_bangumi_timeline","home_bangumi_category"]
    
    //MARK: -- life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        initBaseLayout(layoutAttributes)
        layoutPageSubViews(layoutAttributes)
    }
    
    //MARK: -- private method
    func initBaseLayout(layout: UICollectionViewLayoutAttributes) {
        if backView.subviews.count > 0 {
            for button in backView.subviews {
                button.removeFromSuperview()
            }
        }
        if layout.indexPath.section == 0 {
            recScrollHeight = SCREEN_HEIGHT*0.18
            bangumiScrollView.hidden = false
            secondImage.hidden = true
            self.createButton()
            
        } else if layout.indexPath.section == 1 {
            recScrollHeight = 0
            bangumiScrollView.hidden = true
            secondImage.hidden = false
            
        } else {
            recScrollHeight = 0
            bangumiScrollView.hidden = true
            secondImage.hidden = true
        }
        
        self.addSubview(bangumiScrollView)
        self.addSubview(secondImage)
        self.addSubview(leftImage)
        self.addSubview(leftTitle)
        self.addSubview(moreButton)
        self.addSubview(rightTitle)
        self.addSubview(backView)
    }
    
    func layoutPageSubViews(layout: UICollectionViewLayoutAttributes) {
        if layout.indexPath.section == 0 {
            bangumiScrollView.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self).offset(0)
                make.top.equalTo(self).offset(0)
                make.width.equalTo(SCREEN_WIDTH)
                make.height.equalTo(recScrollHeight)
            })
            backView.snp_makeConstraints { (make) in
                make.top.equalTo(bangumiScrollView.snp_bottom).offset(0)
                make.left.equalTo(self).offset(0)
                make.right.equalTo(self).offset(0)
                make.height.equalTo(SCREEN_HEIGHT*0.23)
            }
        } else if layout.indexPath.section == 1 {
            secondImage.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self).offset(2)
                make.left.equalTo(self).offset(7)
                make.right.equalTo(self).offset(-7)
                make.height.equalTo(SCREEN_HEIGHT*0.18)
            })
        }
        
        leftImage.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-7)
            make.left.equalTo(self).offset(5)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        leftTitle.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-7)
            make.left.equalTo(leftImage.snp_right).offset(3)
            make.width.equalTo(110)
            make.height.equalTo(20)
        }
        moreButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-10)
            make.right.equalTo(self).offset(-5)
            make.width.equalTo(8)
            make.height.equalTo(13)
        }
        rightTitle.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-7)
            make.right.equalTo(moreButton.snp_left).offset(-5)
            make.height.equalTo(20)
        }
    }
    
    func createButton() {
        //分类按钮
        for i in 0..<4 {
            let button = UIButton(type: .Custom)
            button.frame = CGRect(x: 13+CGFloat(i)*(SCREEN_WIDTH*0.21+10), y: 0, width: SCREEN_WIDTH*0.21, height: SCREEN_WIDTH*0.21)
            button.tag = 200+i
            button.backgroundColor = UIColor.clearColor()
            button.titleLabel?.font = UIFont.systemFontOfSize(12)
            button.setTitle(partionName[i], forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.setImage(UIImage(named: partionImg[i]), forState: .Normal)
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 15, -button.titleLabel!.frame.size.height, 0)
            button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView!.frame.size.height+10, -35, -15, 5)
            self.backView.addSubview(button)
        }
        //番剧按钮
        for j in 0..<2 {
            let button = UIButton(type: .Custom)
            button.frame = CGRect(x: 25+CGFloat(j)*(SCREEN_WIDTH*0.40+20), y: SCREEN_WIDTH*0.21+15, width: SCREEN_WIDTH*0.40, height: SCREEN_WIDTH*0.13)
            button.setImage(UIImage(named: bangumiImg[j]), forState: .Normal)
            button.tag = 204+j
            self.backView.addSubview(button)
        }
    }
    
    //MARK: -- delegate
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
    }
    
    //MARK: -- setter and getter
    //第一组的滚动视图
    var _bangumiScrollView: SDCycleScrollView!
    var bangumiScrollView: SDCycleScrollView {
        if _bangumiScrollView == nil {
            _bangumiScrollView = SDCycleScrollView(frame: CGRectZero, imageURLStringsGroup: imageUrlArr)
            _bangumiScrollView.autoScrollTimeInterval = 2.0
            _bangumiScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
            _bangumiScrollView.delegate = self
            _bangumiScrollView.currentPageDotColor = YYMain_Color
            _bangumiScrollView.backgroundColor = UIColor.lightGrayColor()
        }
        return _bangumiScrollView
    }
    //第二组的图片
    var _secondImage: UIImageView!
    var secondImage: UIImageView {
        if _secondImage == nil {
            _secondImage = UIImageView()
            _secondImage.layer.cornerRadius = 10.0
            _secondImage.layer.masksToBounds = true
        }
        return _secondImage
    }
    //每一组的头视图
    var _leftImage: UIImageView!
    var leftImage: UIImageView {
        if _leftImage == nil {
            _leftImage = UIImageView()
            _leftImage.image = UIImage(named: "home_region_icon_33")
        }
        return _leftImage
    }
    
    var _leftTitle: UILabel!
    var leftTitle: UILabel {
        if _leftTitle == nil {
            _leftTitle = UILabel()
            _leftTitle.textColor = UIColor.blackColor()
            _leftTitle.font = UIFont.systemFontOfSize(14)
            _leftTitle.text = "新番连载"
        }
        return _leftTitle
    }
    
    var _rightTitle: UILabel!
    var rightTitle: UILabel {
        if _rightTitle == nil {
            _rightTitle = UILabel()
            _rightTitle.font = UIFont.systemFontOfSize(14)
            _rightTitle.textColor = UIColor.lightGrayColor()
            _rightTitle.textAlignment = .Right
            _rightTitle.text = "更多连载"
        }
        return _rightTitle
    }
    var _moreButton: UIButton!
    var moreButton: UIButton {
        if _moreButton == nil {
            _moreButton = UIButton(type: .Custom)
            _moreButton.setBackgroundImage(UIImage(named: "live_more_ico"), forState: .Normal)
        }
        return _moreButton
    }
    var _backView: UIView!
    var backView: UIView {
        if _backView == nil {
            _backView = UIView()
        }
        return _backView
    }
    //MARK: -- 数据源
    var _bannerArr: [BangumiBannerModel]!
    var bannerArr: [BangumiBannerModel] {
        get {
            return _bannerArr
        }
        set {
            _bannerArr = newValue
            var imageUrl = [String]()
            for i in 0..<newValue.count {
                let url = newValue[i].img
                imageUrl.append(url!)
            }
            self.imageUrlArr = imageUrl
            bangumiScrollView.imageURLStringsGroup = imageUrlArr
        }
    }
    var _bodyArr: [BangumiBodyModel]!
    var bodyArr: [BangumiBodyModel] {
        get {
            return _bodyArr
        }
        set {
            _bodyArr = newValue
            secondImage.sd_setImageWithURL(NSURL(string: newValue[0].bodyImg!))
        }
    }
}