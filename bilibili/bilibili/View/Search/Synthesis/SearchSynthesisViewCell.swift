//
//  SearchSynthesisViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/13.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class SearchSynthesisViewCell: UITableViewCell {
    
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
        self.addSubview(synthImage)
        self.synthImage.addSubview(durationLab)
        self.addSubview(synthTitle)
        self.addSubview(UPLab)
        self.addSubview(playLab)
        self.addSubview(danmakuLab)
    }
    func layoutPageSubviews() {
        synthImage.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(SCREEN_WIDTH*0.32)
            make.height.equalTo(SCREEN_HEIGHT*0.115)
        }
        durationLab.snp_makeConstraints { (make) in
            make.right.equalTo(synthImage.snp_right).offset(-5)
            make.bottom.equalTo(synthImage.snp_bottom).offset(-3)
            make.width.equalTo(45)
            make.height.equalTo(12)
        }
        synthTitle.snp_makeConstraints { (make) in
            make.left.equalTo(synthImage.snp_right).offset(10)
            make.right.equalTo(self).offset(-7)
            make.top.equalTo(self).offset(5)
        }
        UPLab.snp_makeConstraints { (make) in
            make.left.equalTo(synthImage.snp_right).offset(10)
            make.right.equalTo(self).offset(-7)
            make.top.equalTo(synthTitle.snp_bottom).offset(2)
            make.height.equalTo(15)
        }
        playLab.snp_makeConstraints { (make) in
            make.left.equalTo(synthImage.snp_right).offset(10)
            make.top.equalTo(UPLab.snp_bottom).offset(2)
            make.height.equalTo(15)
        }
        danmakuLab.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-7)
            make.top.equalTo(UPLab.snp_bottom).offset(2)
            make.height.equalTo(15)
        }
    }
    
    //MARK: -- setter and getter
    var _synthImage: UIImageView!
    var synthImage: UIImageView {
        if _synthImage == nil {
            _synthImage = UIImageView()
            _synthImage.layer.masksToBounds = true
            _synthImage.layer.cornerRadius = 8.0
        }
        return _synthImage
    }
    
    var _durationLab: UILabel!
    var durationLab: UILabel {
        if _durationLab == nil {
            _durationLab = UILabel()
            _durationLab.textAlignment = .Center
            _durationLab.font = UIFont.systemFontOfSize(9)
            _durationLab.textColor = UIColor.whiteColor()
            _durationLab.backgroundColor = UIColor.grayColor()
            _durationLab.layer.masksToBounds = true
            _durationLab.layer.cornerRadius = 4.0
        }
        return _durationLab
    }
    
    var _synthTitle: UILabel!
    var synthTitle: UILabel {
        if _synthTitle == nil {
            _synthTitle = UILabel()
            _synthTitle.font = UIFont.systemFontOfSize(14)
            _synthTitle.textColor = UIColor.blackColor()
            _synthTitle.numberOfLines = 2
        }
        return _synthTitle
    }
    
    var _UPLab: UILabel!
    var UPLab: UILabel {
        if _UPLab == nil {
            _UPLab = UILabel()
            _UPLab.font = UIFont.systemFontOfSize(11)
            _UPLab.textColor = UIColor.grayColor()
        }
        return _UPLab
    }
    
    var _playLab: UILabel!
    var playLab: UILabel {
        if _playLab == nil {
            _playLab = UILabel()
            _playLab.font = UIFont.systemFontOfSize(11)
            _playLab.textColor = UIColor.grayColor()
        }
        return _playLab
    }

    var _danmakuLab: UILabel!
    var danmakuLab: UILabel {
        if _danmakuLab == nil {
            _danmakuLab = UILabel()
            _danmakuLab.font = UIFont.systemFontOfSize(11)
            _danmakuLab.textColor = UIColor.grayColor()
        }
        return _danmakuLab
    }
    
    //MARK: -- 数据源
    var _archives: ArchiveModel!
    var archives:ArchiveModel {
        get {
            return _archives
        }
        set {
            _archives = newValue
            _synthImage.sd_setImageWithURL(NSURL(string: newValue.cover!) ,placeholderImage: UIImage(named: "default_img"))
            let duration = newValue.duration?.componentsSeparatedByString(":")
            if Int(duration![0]) > 60 {
                let hour = Int(duration![0])! / 60
                let min = Int(duration![0])! % 60
                _durationLab.text = String.init(format: "%d:%d:%@", hour,min,duration![1])
            } else if Int(duration![0]) < 10 && Int(duration![1]) >= 10 {
                _durationLab.text = String.init(format: "00:0%@:%@", duration![0],duration![1])
            } else if Int(duration![0]) >= 10 && Int(duration![1]) < 10 {
                _durationLab.text = String.init(format: "00:%@:0%@", duration![0],duration![1])
            } else if Int(duration![0]) < 10 && Int(duration![1]) < 10 {
                _durationLab.text = String.init(format: "00:0%@:0%@", duration![0],duration![1])
            } else {
                _durationLab.text = String.init(format: "00:%@", newValue.duration!)
            }
            _synthTitle.text = newValue.title
            _UPLab.text = String.init(format: "UP主：%@", newValue.author!)
            _playLab.text = String.init(format: "播放：%d", newValue.play!)
            _danmakuLab.text = String.init(format: "弹幕：%d", newValue.danmaku!)
        }
    }
}
