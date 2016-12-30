//
//  MineInfoHeader.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/26.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class MineInfoHeader: UICollectionReusableView {
    
    //MARK: -- life cycle
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
        self.addSubview(classifyLab)
        self.addSubview(moreLabel)
        self.addSubview(moreButton)
    }
    func layoutPageSubviews() {
        classifyLab.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.height.equalTo(20)
            make.width.equalTo(150)
        }
        moreButton.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
            make.height.equalTo(15)
            make.width.equalTo(15)
        }
        moreLabel.snp_makeConstraints { (make) in
            make.right.equalTo(moreButton.snp_left).offset(-2)
            make.centerY.equalTo(self)
            make.height.equalTo(15)
        }
    }
    
    //MARK: -- setter and getter
    var _classifyLab: UILabel!
    var classifyLab: UILabel {
        if _classifyLab == nil {
            _classifyLab = UILabel()
            _classifyLab.textColor = UIColor.blackColor()
        }
        return _classifyLab
    }
    var _moreLabel: UILabel!
    var moreLabel: UILabel {
        if _moreLabel == nil {
            _moreLabel = UILabel()
            _moreLabel.text = "进去看看!"
            _moreLabel.textAlignment = .Right
            _moreLabel.textColor = UIColor.grayColor()
            _moreLabel.font = UIFont.systemFontOfSize(13)
        }
        return _moreLabel
    }
    var _moreButton: UIButton!
    var moreButton: UIButton {
        if _moreButton == nil {
            _moreButton = UIButton()
            _moreButton.setImage(UIImage(named: "common_rightArrowShadow"), forState: .Normal)
        }
        return _moreButton
    }
}
