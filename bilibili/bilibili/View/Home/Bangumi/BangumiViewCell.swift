//
//  BangumiViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/16.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class BangumiViewCell: UICollectionViewCell {
    
    
    var gradientLayer: CAGradientLayer!
    
    //MARK: -- life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initBaseLayout()
        layoutPageSubViews()
        
        gradientLayer.frame = CGRectMake(0, SCREEN_HEIGHT*0.22-30, self.contentView.bounds.size.width, 30)
        gradientLayer.colors = [UIColor.clearColor(),UIColor.blackColor().CGColor]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -- private method
    func initBaseLayout() {
        gradientLayer = CAGradientLayer()
        self.addSubview(bangumiImg)
        self.bangumiImg.layer.addSublayer(gradientLayer)
        self.addSubview(bangumiTitle)
        self.addSubview(infoTitle)
        self.addSubview(newestTitle)
    }
    func layoutPageSubViews() {
        bangumiImg.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(SCREEN_HEIGHT*0.22)
        }
        bangumiTitle.snp_makeConstraints { (make) in
            make.top.equalTo(bangumiImg.snp_bottom).offset(2)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
        }
        infoTitle.snp_makeConstraints { (make) in
            make.bottom.equalTo(bangumiImg.snp_bottom).offset(0)
            make.left.equalTo(bangumiImg.snp_left).offset(4)
            make.right.equalTo(bangumiImg.snp_right).offset(4)
            make.height.equalTo(20)
        }
        newestTitle.snp_makeConstraints { (make) in
            make.top.equalTo(bangumiTitle.snp_bottom).offset(3)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(15)
        }
    }
    
    //MARK: -- setter and getter
    var _bangumiImg: UIImageView!
    var bangumiImg: UIImageView {
        if _bangumiImg == nil {
            _bangumiImg = UIImageView()
            _bangumiImg.layer.cornerRadius = 10.0
            _bangumiImg.layer.masksToBounds = true
        }
        return _bangumiImg
    }
    
    var _infoTitle: UILabel!
    var infoTitle: UILabel {
        if _infoTitle == nil {
            _infoTitle = UILabel()
            _infoTitle.textColor = UIColor.whiteColor()
            _infoTitle.font = UIFont.systemFontOfSize(11)
        }
        return _infoTitle
    }
    
    var _bangumiTitle: UILabel!
    var bangumiTitle: UILabel {
        if _bangumiTitle == nil {
            _bangumiTitle = UILabel()
            _bangumiTitle.numberOfLines = 2
            _bangumiTitle.textColor = UIColor.blackColor()
            _bangumiTitle.font = UIFont.systemFontOfSize(13)
        }
        return _bangumiTitle
    }
    
    var _newestTitle: UILabel!
    var newestTitle: UILabel {
        if _newestTitle == nil {
            _newestTitle = UILabel()
            _newestTitle.textColor = UIColor.grayColor()
            _newestTitle.font = UIFont.systemFontOfSize(11)
        }
        return _newestTitle
    }
    
    //数据源
    var _firstModel: BangumiFirstModel!
    var firstModel: BangumiFirstModel {
        get {
            return _firstModel
        }
        set {
            _firstModel = newValue
            bangumiImg.sd_setImageWithURL(NSURL(string: newValue.cover!), placeholderImage: UIImage(named: "default_img"))
            bangumiTitle.text = newValue.title
            infoTitle.text = String.init(format: "%d人在看", newValue.watching_count!)
            newestTitle.text = String.init(format: "更新至第%@话", newValue.newest_ep_index!)
        }
    }
    var _secondModel: BangumiSecondDeatilsModel!
    var secondModel: BangumiSecondDeatilsModel {
        get {
            return _secondModel
        }
        set {
            _secondModel = newValue
            bangumiImg.sd_setImageWithURL(NSURL(string: newValue.cover!))
            bangumiTitle.text = newValue.title
            infoTitle.text = String.init(format: "%d万人追番", Int(newValue.favourites!)!%10000)
            newestTitle.hidden = true
        }
    }
}
