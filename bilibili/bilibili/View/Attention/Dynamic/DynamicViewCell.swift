//
//  DynamicViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class DynamicViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initBaseLayout()
        layoutPageSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.addSubview(dynamicImg)
        self.addSubview(dynamicTitle)
    }
    
    func layoutPageSubviews() {
        dynamicImg.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(2)
            make.left.equalTo(self).offset(2)
            make.right.equalTo(self).offset(-2)
            make.height.equalTo(SCREEN_HEIGHT*0.18)
        }
        dynamicTitle.snp_makeConstraints { (make) in
            make.top.equalTo(dynamicImg.snp_bottom).offset(5)
            make.left.equalTo(self).offset(2)
            make.height.equalTo(35)
            make.width.equalTo(self)
        }
    }
    
    //MARK: -- setter and getter
    var _dynamicImg: UIImageView!
    var dynamicImg: UIImageView {
        if _dynamicImg == nil {
            _dynamicImg = UIImageView()
            _dynamicImg.layer.cornerRadius = 10.0
            _dynamicImg.layer.masksToBounds = true
        }
        return _dynamicImg
    }
    var _dynamicTitle: UILabel!
    var dynamicTitle: UILabel {
        if _dynamicTitle == nil {
            _dynamicTitle = UILabel()
            _dynamicTitle.font = UIFont.systemFontOfSize(12)
            _dynamicTitle.numberOfLines = 2
        }
        return _dynamicTitle
    }
    
    var _dynamicVideos: DynamicVideoModel!
    var dynamicVideos: DynamicVideoModel {
        get {
            return _dynamicVideos
        }
        set {
            _dynamicVideos = newValue
            _dynamicImg.sd_setImageWithURL(NSURL(string: newValue.cover!), placeholderImage: UIImage(named: "default_img"))
            _dynamicTitle.text = newValue.title            
        }
    }
    
}
