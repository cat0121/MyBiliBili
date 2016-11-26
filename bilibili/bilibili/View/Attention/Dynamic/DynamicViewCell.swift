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
            make.left.equalTo(self).offset(0)
            make.width.equalTo(self)
            make.height.equalTo(SCREEN_HEIGHT*0.18)
        }
        dynamicTitle.snp_makeConstraints { (make) in
            make.top.equalTo(dynamicImg.snp_bottom).offset(5)
            make.left.equalTo(self).offset(0)
            make.height.equalTo(35)
            make.width.equalTo(self)
        }
    }
    
    //MARK: -- setter and getter
    var _chaseImg: UIImageView!
    var dynamicImg: UIImageView {
        if _chaseImg == nil {
            _chaseImg = UIImageView()
            _chaseImg.layer.cornerRadius = 10.0
            _chaseImg.layer.masksToBounds = true
        }
        return _chaseImg
    }
    var _chaseTitle: UILabel!
    var dynamicTitle: UILabel {
        if _chaseTitle == nil {
            _chaseTitle = UILabel()
            _chaseTitle.font = UIFont.systemFontOfSize(12)
            _chaseTitle.numberOfLines = 2
        }
        return _chaseTitle
    }
    
}
