//
//  SeasonViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/26.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class SeasonViewCell: UICollectionViewCell {
    
    var gradientLayer: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initBaseLayout()
        layoutPageSubview()
        
        gradientLayer.frame = CGRectMake(0, 100, SCREEN_WIDTH*0.28, SCREEN_HEIGHT*0.217-100)
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
        self.icon.addSubview(title)
        self.icon.addSubview(season)
    }
    func layoutPageSubview() {
        icon.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.height.equalTo(SCREEN_HEIGHT*0.217)
            make.width.equalTo(SCREEN_WIDTH*0.28)
        }
        title.snp_makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-25)
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-5)
            make.height.equalTo(20)
        }
        season.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(icon.snp_bottom).offset(-5)
            make.height.equalTo(15)
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
    var _title: UILabel!
    var title: UILabel {
        if _title == nil {
            _title = UILabel()
            _title.textColor = UIColor.whiteColor()
            _title.font = UIFont.systemFontOfSize(13)
        }
        return _title
    }
    var _season: UILabel!
    var season: UILabel {
        if _season == nil {
            _season = UILabel()
            _season.textColor = UIColor.whiteColor()
            _season.font = UIFont.systemFontOfSize(11)
        }
        return _season
    }
    var _seasonModel: SeasonItem!
    var seasonModel: SeasonItem {
        get {
            return _seasonModel
        }
        set {
            _seasonModel = newValue
            _icon.sd_setImageWithURL(NSURL(string: newValue.cover!))
            _title.text = newValue.title
            if Int(newValue.newest_ep_index!) < Int(newValue.total_count!) {
                _season.text = String.init(format: "更新至%@话", newValue.newest_ep_index!)
            } else {
                _season.text = String.init(format: "%@话", newValue.total_count!)
            }
        }
    }
}
