//
//  SerialCartoonViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/18.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import UIKit

class SerialCartoonViewCell: UITableViewCell {
    
    //MARK: -- life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initBaseLayout()
        layoutPageSubViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.addSubview(sericalImage)
        self.addSubview(sericalTitle)
        self.addSubview(UPTitle)
        self.addSubview(playTitle)
        self.addSubview(danmukTitle)
    }
    func layoutPageSubViews() {
        sericalImage.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.height.equalTo(SCREEN_HEIGHT*0.11)
            make.width.equalTo(SCREEN_WIDTH*0.31)
        }
        sericalTitle.snp_makeConstraints { (make) in
            make.left.equalTo(sericalImage.snp_right).offset(5)
            make.top.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-10)
        }
        UPTitle.snp_makeConstraints { (make) in
            make.left.equalTo(sericalImage.snp_right).offset(5)
            make.top.equalTo(sericalTitle.snp_bottom).offset(2)
            make.height.equalTo(20)
        }
        playTitle.snp_makeConstraints { (make) in
            make.left.equalTo(sericalImage.snp_right).offset(5)
            make.top.equalTo(UPTitle.snp_bottom).offset(2)
            make.height.equalTo(20)
        }
        danmukTitle.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(UPTitle.snp_bottom).offset(2)
            make.height.equalTo(20)
            
        }
    }
    
    //MARK: -- setter and getter
    var _sericalImage: UIImageView!
    var sericalImage: UIImageView {
        if _sericalImage == nil {
            _sericalImage = UIImageView()
            _sericalImage.layer.cornerRadius = 10.0
            _sericalImage.layer.masksToBounds = true
        }
        return _sericalImage
    }
    
    var _sericalTitle: UILabel!
    var sericalTitle: UILabel {
        if _sericalTitle == nil {
            _sericalTitle = UILabel()
            _sericalTitle.numberOfLines = 2
            _sericalTitle.textColor = UIColor.blackColor()
            _sericalTitle.font = UIFont.systemFontOfSize(14)
        }
        return _sericalTitle
    }
    
    var _UPTitle: UILabel!
    var UPTitle: UILabel {
        if _UPTitle == nil {
            _UPTitle = UILabel()
            _UPTitle.textColor = UIColor.grayColor()
            _UPTitle.font = UIFont.systemFontOfSize(12)
        }
        return _UPTitle
    }
    
    var _playTitle: UILabel!
    var playTitle: UILabel {
        if _playTitle == nil {
            _playTitle = UILabel()
            _playTitle.font = UIFont.systemFontOfSize(10)
            _playTitle.textColor = UIColor.grayColor()
        }
        return _playTitle
    }
    
    var _danmukTitle: UILabel!
    var danmukTitle: UILabel {
        if _danmukTitle ==  nil {
            _danmukTitle = UILabel()
            _danmukTitle.textColor = UIColor.grayColor()
            _danmukTitle.font = UIFont.systemFontOfSize(10)
            _danmukTitle.textAlignment = .Right
        }
        return _danmukTitle
    }
    
    //数据源
    var _recommendModel: RecCartoonModel!
    var recommendModel: RecCartoonModel {
        get {
            return _recommendModel
        }
        set {
            _recommendModel = newValue
            sericalImage.sd_setImageWithURL(NSURL(string: newValue.cover!))
            sericalTitle.text = newValue.title
            UPTitle.text = String.init(format: "UP主：%@", newValue.name!)
            playTitle.text = String.init(format: "播放：%d万", newValue.play!/10000)
            danmukTitle.text = String.init(format: "弹幕：%d", newValue.danmaku!)
        }
    }
    var _newModel: NewCartoonModel!
    var newModel: NewCartoonModel {
        get {
            return _newModel
        }
        set {
            _newModel = newValue
            sericalImage.sd_setImageWithURL(NSURL(string: newValue.cover!), placeholderImage: UIImage(named: "default_img"))
            sericalTitle.text = newValue.title
            UPTitle.text = String.init(format: "UP主：%@", newValue.name!)
            playTitle.text = String.init(format: "播放：%d万", newValue.play!/10000)
            danmukTitle.text = String.init(format: "弹幕：%d", newValue.danmaku!)
        }
    }
}