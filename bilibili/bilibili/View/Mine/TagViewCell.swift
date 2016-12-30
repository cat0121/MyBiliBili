//
//  TagViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/26.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class TagViewCell: UICollectionViewCell {
    
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
        self.addSubview(markLab)
    }
    func layoutPageSubviews() {
        markLab.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(2)
            make.width.equalTo(50)
            make.height.equalTo(SCREEN_HEIGHT*0.038)
        }
    }
    
    //MARK: -- setter and getter
    var _markLab: UILabel!
    var markLab: UILabel {
        if _markLab == nil {
            _markLab = UILabel()
            _markLab.layer.borderWidth = 1
            _markLab.textAlignment = .Center
            _markLab.backgroundColor = UIColor.whiteColor()
            _markLab.font = UIFont.systemFontOfSize(12)
            _markLab.textColor = UIColor.blackColor()
            _markLab.layer.borderColor = UIColor.lightGrayColor().CGColor
            _markLab.layer.masksToBounds = true
            _markLab.layer.cornerRadius = 13.0
        }
        return _markLab
    }
    var _tagModel: TagModel!
    var tagModel: TagModel {
        get {
            return _tagModel
        }
        set {
            _tagModel = newValue
            _markLab.text = newValue.tag_name
        }
    }
}
