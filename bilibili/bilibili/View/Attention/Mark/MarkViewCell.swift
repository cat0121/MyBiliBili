//
//  MarkViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/2.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import UIKit

class MarkViewCell: UITableViewCell {
    
    //MARK: -- life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initBaseLayout()
        layoutPageSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.addSubview(markImg)
        self.addSubview(markTitle)
        self.addSubview(markUP)
        self.addSubview(markPlay)
        self.addSubview(markDanmaku)
    }
    func layoutPageSubviews() {
        markImg.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(2)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(SCREEN_WIDTH*0.3)
            make.height.equalTo(SCREEN_HEIGHT*0.11)
        }
        markTitle.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(4)
            make.left.equalTo(markImg.snp_right).offset(7)
            make.right.equalTo(self).offset(-12)
        }
        markUP.snp_makeConstraints { (make) in
            make.top.equalTo(markTitle.snp_bottom).offset(5)
            make.left.equalTo(markImg.snp_right).offset(7)
            make.height.equalTo(15)
        }
        markPlay.snp_makeConstraints { (make) in
            make.top.equalTo(markUP.snp_bottom).offset(5)
            make.left.equalTo(markImg.snp_right).offset(7)
            make.height.equalTo(15)
        }
        markDanmaku.snp_makeConstraints { (make) in
            make.top.equalTo(markUP.snp_bottom).offset(5)
            make.right.equalTo(self).offset(-9)
            make.height.equalTo(15)
        }
    }
    
    //MARK: -- setter and getter
    var _markImg: UIImageView!
    var markImg: UIImageView {
        if _markImg == nil {
            _markImg = UIImageView()
            _markImg.layer.cornerRadius = 8.0
            _markImg.layer.masksToBounds = true
        }
        return _markImg
    }
    
    var _markTitle: UILabel!
    var markTitle: UILabel {
        if _markTitle == nil {
            _markTitle = UILabel()
            _markTitle.numberOfLines = 2
            _markTitle.font = UIFont.systemFontOfSize(14)
        }
        return _markTitle
    }
    
    var _markUP: UILabel!
    var markUP: UILabel {
        if _markUP == nil {
            _markUP = UILabel()
            _markUP.textColor = UIColor.grayColor()
            _markUP.font = UIFont.systemFontOfSize(11)
        }
        return _markUP
    }
    
    var _markPlay: UILabel!
    var markPlay: UILabel {
        if _markPlay == nil {
            _markPlay = UILabel()
            _markPlay.textColor = UIColor.grayColor()
            _markPlay.font = UIFont.systemFontOfSize(11)
        }
        return _markPlay
    }
    
    var _markDanmaku: UILabel!
    var markDanmaku: UILabel {
        if _markDanmaku == nil {
            _markDanmaku = UILabel()
            _markDanmaku.textColor = UIColor.grayColor()
            _markDanmaku.font = UIFont.systemFontOfSize(11)
            _markDanmaku.textAlignment = .Right
        }
        return _markDanmaku
    }
    
    //数据
    var _addition: AdditionModel!
    var addition: AdditionModel {
        get {
            return _addition
        }
        set {
            _addition = newValue
            _markImg.sd_setImageWithURL(NSURL(string: newValue.pic!), placeholderImage: UIImage(named: "default_img"))
            _markTitle.text = newValue.title
            _markUP.text = String.init(format: "UP主：%@", newValue.UP!)
            _markPlay.text = String.init(format: "播放：%d", newValue.play!)
            _markDanmaku.text = String.init(format: "弹幕：%d", newValue.danmaku!)
        }
    }
}