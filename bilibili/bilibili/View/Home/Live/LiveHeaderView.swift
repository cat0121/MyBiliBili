//
//  LiveHeaderView.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/15.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import SDCycleScrollView

class LiveHeaderView: UICollectionReusableView, SDCycleScrollViewDelegate {
    
    var recScrollHeight: CGFloat!
    var imageUrlArr = [String]()
    var recLayout: UICollectionViewLayoutAttributes?
    
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
        recLayout = layout
        if layout.indexPath.section == 0 {
            recScrollHeight = SCREEN_HEIGHT*0.18
            liveScrollView.hidden = false
        } else {
            recScrollHeight = 0
            liveScrollView.hidden = true
        }
        self.addSubview(liveScrollView)
        self.addSubview(leftImage)
        self.addSubview(leftTitle)
        self.addSubview(moreButton)
        self.addSubview(rightTitle)
    }
    func layoutPageSubViews(layout: UICollectionViewLayoutAttributes) {
        if layout.indexPath.section == 0 {
            liveScrollView.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self).offset(0)
                make.top.equalTo(self).offset(0)
                make.width.equalTo(SCREEN_WIDTH)
                make.height.equalTo(recScrollHeight)
            })
        }
        leftImage.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-5)
            make.left.equalTo(self).offset(5)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        leftTitle.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-5)
            make.left.equalTo(leftImage.snp_right).offset(3)
            make.width.equalTo(110)
            make.height.equalTo(20)
        }
        moreButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-8)
            make.right.equalTo(self).offset(-5)
            make.width.equalTo(8)
            make.height.equalTo(13)
        }
        rightTitle.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-5)
            make.right.equalTo(moreButton.snp_left).offset(-5)
            make.height.equalTo(20)
        }
        
    }
    //设置部分字体颜色
    func changeTextColor(label: UILabel, startRange: NSRange, textColor: UIColor) {
        let attributedString = NSMutableAttributedString(string: label.text!)
        //设置颜色
        attributedString.addAttribute(NSForegroundColorAttributeName, value: textColor, range: NSMakeRange(startRange.location, startRange.length))
        //设置尺寸
        label.attributedText = attributedString
    }
    //找出view所属的控制器进行页面之间的跳转   2016.8.29 高琳琳
    func controller(view:UIView)->UIViewController?{
        for var next:UIView? = view;next != nil;next = next!.superview{
            if let nextResponder = next?.nextResponder() where nextResponder.isKindOfClass(UIViewController.self){
                return (nextResponder as! UIViewController)
            }
        }
        return nil
    }
    //MARK: -- delegate
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        let vc = self.controller(self)! as UIViewController
        let banner = BannerDetailViewController()
        banner.url = bannerModelArr[index].uri
        banner.title = bannerModelArr[index].title
        vc.navigationController?.pushViewController(banner, animated: false)
    }
    
    //MARK: -- setter and getter
    //第一组的滚动视图
    var _liveScrollView: SDCycleScrollView!
    var liveScrollView: SDCycleScrollView {
        if _liveScrollView == nil {
            _liveScrollView = SDCycleScrollView(frame: CGRectZero, imageURLStringsGroup: imageUrlArr)
            _liveScrollView.autoScrollTimeInterval = 2.0
            _liveScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
            _liveScrollView.delegate = self
            _liveScrollView.currentPageDotColor = YYMain_Color
            _liveScrollView.backgroundColor = UIColor.lightGrayColor()
        }
        return _liveScrollView
    }
    //每一组的头视图
    var _leftImage: UIImageView!
    var leftImage: UIImageView {
        if _leftImage == nil {
            _leftImage = UIImageView()
        }
        return _leftImage
    }
    
    var _leftTitle: UILabel!
    var leftTitle: UILabel {
        if _leftTitle == nil {
            _leftTitle = UILabel()
            _leftTitle.textColor = UIColor.blackColor()
            _leftTitle.font = UIFont.systemFontOfSize(14)
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
        }
        return _rightTitle
    }
    var _moreButton: UIButton!
    var moreButton: UIButton {
        if _moreButton == nil {
            _moreButton = UIButton(type: .Custom)
            _moreButton.setBackgroundImage(UIImage(named: "common_rightArrowShadow"), forState: .Normal)
        }
        return _moreButton
    }
    //MARK: -- 数据源
    var _bannerModelArr: [LiveBannerModel]!
    var bannerModelArr: [LiveBannerModel] {
        get {
            return _bannerModelArr
        }
        set {
            _bannerModelArr = newValue
            var imageUrl = [String]()
            for i in 0..<newValue.count {
                let url = newValue[i].img
                imageUrl.append(url!)
            }
            self.imageUrlArr = imageUrl
            liveScrollView.imageURLStringsGroup = imageUrlArr
        }
    }
    var _liveDetailsModel: PartionsModel!
    var liveDetailsModel: PartionsModel {
        get {
            return _liveDetailsModel
        }
        set {
            _liveDetailsModel = newValue
            leftImage.sd_setImageWithURL(NSURL(string: newValue.srcIcon!))
            leftTitle.text = newValue.name
            rightTitle.text = String(format: "当前%d个直播，进去看看", newValue.count!)
            changeTextColor(rightTitle, startRange: NSMakeRange(2, NSString(string: rightTitle.text!).length - 2 - 8), textColor: YYMain_Color)
        }
    }
}