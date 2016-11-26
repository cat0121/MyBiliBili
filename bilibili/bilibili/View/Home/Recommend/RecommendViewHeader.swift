//
//  RecommendViewHeader.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/10.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit
import SnapKit
import SDCycleScrollView

class RecommendViewHeader: UICollectionReusableView, SDCycleScrollViewDelegate {
    
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
            recScrollView.hidden = false
        } else {
            recScrollHeight = 0
            recScrollView.hidden = true
        }
        self.addSubview(recScrollView)
        self.addSubview(leftImage)
        self.addSubview(leftTitle)
        self.addSubview(moreButton)
        self.addSubview(rightTitle)
    }
    func layoutPageSubViews(layout: UICollectionViewLayoutAttributes) {
        if layout.indexPath.section == 0 {
            recScrollView.snp_makeConstraints(closure: { (make) in
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
            make.bottom.equalTo(self.snp_bottom).offset(-7)
            make.right.equalTo(self).offset(-5)
            make.width.equalTo(8)
            make.height.equalTo(15)
        }
        rightTitle.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-5)
            make.right.equalTo(moreButton.snp_left).offset(-5)
            make.width.equalTo(110)
            make.height.equalTo(20)
        }
        
    }
    //MARK: -- delegate
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
    }
    
    //MARK: -- setter and getter
    //第一组的滚动视图
    var _recScrollView: SDCycleScrollView!
    var recScrollView: SDCycleScrollView {
        if _recScrollView == nil {
            _recScrollView = SDCycleScrollView(frame: CGRectZero, imageURLStringsGroup: imageUrlArr)
            _recScrollView.autoScrollTimeInterval = 2.0
            _recScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
            _recScrollView.delegate = self
            _recScrollView.currentPageDotColor = YYMain_Color
            _recScrollView.backgroundColor = UIColor.lightGrayColor()
        }
        return _recScrollView
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
            _rightTitle.textAlignment = .Right
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
    //MARK: -- 数据源
    var _bannerModelArr: [RecBannerModel]!
    var bannerModelArr: [RecBannerModel] {
        get {
            return _bannerModelArr
        }
        set {
            _bannerModelArr = newValue
            var imageUrl = [String]()
            for i in 0..<newValue.count {
                let url = newValue[i].bannerImage
                imageUrl.append(url!)
            }
            self.imageUrlArr = imageUrl
            recScrollView.imageURLStringsGroup = imageUrlArr
        }
    }
    var _recDetailsModel: RecDetailsModel!
    var recDetailsModel: RecDetailsModel {
        get {
            return _recDetailsModel
        }
        set {
            _recDetailsModel = newValue
            leftTitle.text = newValue.headerTitle
            if recLayout?.indexPath.section == 0 {
                rightTitle.text = "排行榜"
                rightTitle.textColor = UIColor(red: 247/255.0, green: 197/255.0, blue: 99/255.0, alpha: 1)
            } else {
                rightTitle.text = String(format: "更多%@", (newValue.headerTitle as NSString).substringToIndex(2))
            }
        }
    }
}
