//
//  LiveViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/15.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class LiveViewCell: UICollectionViewCell {
    
    //MARK: -- life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initBaseLayout()
        layoutPageSubviews()
        let gradientyLayer = CAGradientLayer()
        gradientyLayer.frame = self.bounds
        gradientyLayer.colors = [UIColor.lightGrayColor(),UIColor.grayColor(),UIColor.blackColor()]
//        backImage.layer.addSublayer(gradientyLayer)
        self.contentView.layer.insertSublayer(gradientyLayer, atIndex: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.contentView.addSubview(liveImage)
        self.contentView.addSubview(liveTitle)
        self.liveImage.addSubview(backImage)
        self.backImage.addSubview(authorTitle)
        self.backImage.addSubview(watchNumImg)
        self.backImage.addSubview(watchNum)
    }
    func layoutPageSubviews() {
        liveImage.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(3)
            make.left.equalTo(self.contentView).offset(0)
            make.right.equalTo(self.contentView).offset(0)
            make.height.equalTo(self.contentView.bounds.size.height - 40)
        }
        liveTitle.snp_makeConstraints { (make) in
            make.top.equalTo(liveImage.snp_bottom).offset(3)
            make.left.equalTo(self.contentView).offset(0)
            make.right.equalTo(self.contentView).offset(0)
        }
        backImage.snp_makeConstraints { (make) in
            make.bottom.equalTo(liveImage.snp_bottom).offset(0)
            make.left.equalTo(self.contentView).offset(0)
            make.right.equalTo(self.contentView).offset(0)
            make.height.equalTo(22)
        }
        authorTitle.snp_makeConstraints { (make) in
            make.bottom.equalTo(backImage.snp_bottom).offset(-3)
            make.left.equalTo(backImage.snp_left).offset(9)
            make.width.equalTo(110)
            make.height.equalTo(20)
        }
        watchNumImg.snp_makeConstraints { (make) in
            make.left.equalTo(authorTitle.snp_right).offset(10)
            make.bottom.equalTo(backImage.snp_bottom).offset(-5)
            make.width.equalTo(16)
            make.height.equalTo(13)
        }
        watchNum.snp_makeConstraints { (make) in
            make.left.equalTo(watchNumImg.snp_right).offset(3)
            make.bottom.equalTo(backImage.snp_bottom).offset(-2)
            make.height.equalTo(20)
        }
    }
    
    //MARK: -- setter and getter
    var _liveImage: UIImageView!
    var liveImage: UIImageView {
        if _liveImage == nil {
            _liveImage = UIImageView()
            _liveImage.layer.cornerRadius = 10.0
            _liveImage.layer.masksToBounds = true
        }
        return _liveImage
    }
    
    var _backImage: UIImageView!
    var backImage: UIImageView {
        if _backImage == nil {
            _backImage = UIImageView()
//            _backImage.backgroundColor = UIColor.grayColor()
//            _backImage.alpha = 0.8
            
        }
        return _backImage
    }
    
    var _authorTitle: UILabel!
    var authorTitle: UILabel {
        if _authorTitle == nil {
            _authorTitle = UILabel()
            _authorTitle.textColor = UIColor.whiteColor()
            _authorTitle.font  = UIFont.systemFontOfSize(12)
        }
        return _authorTitle
    }
    
    var _watchNumImg: UIImageView!
    var watchNumImg: UIImageView {
        if _watchNumImg == nil {
            _watchNumImg = UIImageView()
            _watchNumImg.image = UIImage(named: "live_online_ico")
        }
        return _watchNumImg
    }
    
    var _watchNum: UILabel!
    var watchNum: UILabel {
        if _watchNum == nil {
            _watchNum = UILabel()
            _watchNum.textColor = UIColor.whiteColor()
            _watchNum.font = UIFont.boldSystemFontOfSize(11)
        }
        return _watchNum
    }
    
    var _liveTitle: UILabel!
    var liveTitle: UILabel {
        if _liveTitle == nil {
            _liveTitle = UILabel()
            _liveTitle.numberOfLines = 2
            _liveTitle.textColor = UIColor.blackColor()
            _liveTitle.font = UIFont.systemFontOfSize(13)
        }
        return _liveTitle
    }
    
    //数据源
    var _pationsModel: PartionsDetailsModel!
    var pationsModel: PartionsDetailsModel {
        get {
            return _pationsModel
        }
        set {
            _pationsModel = newValue
            liveImage.sd_setImageWithURL(NSURL(string: newValue.srcImage!))
            liveTitle.text = newValue.title
            watchNum.text = String(format: "%d", newValue.online!)
            authorTitle.text = newValue.authorName
        }
    }
    
}