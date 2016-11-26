//
//  DynamicViewHeader.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class DynamicViewHeader: UICollectionReusableView {
    
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
        self.addSubview(authorIcon)
        self.addSubview(authorName)
        self.addSubview(fanNum)
        self.addSubview(attentionBtn)
    }
    func layoutPageSubviews() {
        authorIcon.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(3)
            make.width.equalTo(SCREEN_WIDTH*0.12)
            make.height.equalTo(SCREEN_WIDTH*0.12)
        }
        authorName.snp_makeConstraints { (make) in
            make.left.equalTo(authorIcon.snp_right).offset(10)
            make.top.equalTo(self).offset(8)
            make.height.equalTo(25)
        }
        fanNum.snp_makeConstraints { (make) in
            make.left.equalTo(authorIcon.snp_right).offset(10)
            make.top.equalTo(authorName.snp_bottom).offset(3)
            make.height.equalTo(20)
        }
        attentionBtn.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(8)
            make.height.equalTo(25)
            make.width.equalTo(40)
        }
    }
    
    //MARK: -- private method
    var _authorIcon: UIImageView!
    var authorIcon: UIImageView {
        if _authorIcon == nil {
            _authorIcon = UIImageView()
            _authorIcon.layer.cornerRadius = 45.0
            _authorIcon.layer.masksToBounds = true
        }
        return _authorIcon
    }
    var _authorName: UILabel!
    var authorName: UILabel {
        if _authorName == nil {
            _authorName = UILabel()
            _authorName.font = UIFont.systemFontOfSize(12)
        }
        return _authorName
    }
    var _fanNum: UILabel!
    var fanNum: UILabel {
        if _fanNum == nil {
            _fanNum = UILabel()
            _fanNum.font = UIFont.systemFontOfSize(10)
            _fanNum.textColor = UIColor.grayColor()
        }
        return _fanNum
    }
    var _attentionBtn: UIButton!
    var attentionBtn: UIButton {
        if _attentionBtn == nil {
            _attentionBtn = UIButton(type: .Custom)
            _attentionBtn.layer.masksToBounds = true
            _attentionBtn.layer.cornerRadius = 10.0
            //设置边界高度
            _attentionBtn.layer.borderWidth = 1
            //设置按钮的边界颜色
            _attentionBtn.layer.borderColor = YYMain_Color.CGColor
            _attentionBtn.setTitle("关注", forState: .Normal)
            _attentionBtn.setTitleColor(YYMain_Color, forState: .Normal)
            _attentionBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        }
        return _attentionBtn
    }
}
