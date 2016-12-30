//
//  FavouriteViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/26.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class FavouriteViewCell: UICollectionViewCell {
    
    var gradientLayer: CAGradientLayer!
    
    //MARK: -- life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initBaseLayout()
        layoutPageSubview()
        
        gradientLayer.frame = CGRectMake(0, 80, self.frame.size.width-10, 50)
        gradientLayer.colors = [UIColor.clearColor().CGColor,UIColor.blackColor().CGColor]
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        gradientLayer = CAGradientLayer()
        self.addSubview(icon)
        self.icon.layer.addSublayer(gradientLayer)
        self.icon.addSubview(curCount)
        self.icon.addSubview(title)
    }
    func layoutPageSubview() {
        icon.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-5)
        }
        curCount.snp_makeConstraints { (make) in
            make.top.equalTo(icon.snp_top).offset(3)
            make.right.equalTo(icon.snp_right).offset(-3)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }
        title.snp_makeConstraints { (make) in
            make.bottom.equalTo(icon.snp_bottom).offset(-5)
            make.left.equalTo(icon.snp_left).offset(5)
            make.right.equalTo(icon.snp_right).offset(-5)
            make.height.equalTo(18)
        }
    }
    
    //MARK: -- setter and getter
    var _icon: UIImageView!
    var icon: UIImageView {
        if _icon == nil {
            _icon = UIImageView()
            _icon.layer.masksToBounds = true
            _icon.layer.cornerRadius = 10.0
        }
        return _icon
    }
    
    var _curCount: UILabel!
    var curCount: UILabel {
        if _curCount == nil {
            _curCount = UILabel()
            _curCount.textColor = UIColor.whiteColor()
            _curCount.font = UIFont.systemFontOfSize(10)
        }
        return _curCount
    }
    
    var _title: UILabel!
    var title: UILabel {
        if _title == nil {
            _title = UILabel()
            _title.textColor = UIColor.whiteColor()
            _title.font = UIFont.systemFontOfSize(13)
        }
        return _title
    }
    
    var _favourite: FavouriteItem!
    var favourite: FavouriteItem {
        get {
            return _favourite
        }
        set {
            _favourite = newValue
            _icon.sd_setImageWithURL(NSURL(string: newValue.pic!))
            _curCount.text = String.init(format: "%d", newValue.cur_count!)
            _title.text = String.init(format: "%@", newValue.name!)
        }
    }
}
