//
//  SearchSubjectViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/19.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class SearchSubjectViewCell: UITableViewCell {
    
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
        self.addSubview(userImg)
        self.addSubview(TitleLab)
        self.addSubview(archivesLab)
        self.addSubview(playLab)
        self.addSubview(descLab)
    }
    func layoutPageSubviews() {
        userImg.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.width.equalTo(SCREEN_HEIGHT*0.104)
            make.height.equalTo(SCREEN_HEIGHT*0.104)
        }
        TitleLab.snp_makeConstraints { (make) in
            make.left.equalTo(userImg.snp_right).offset(10)
            make.top.equalTo(self).offset(10)
            make.height.equalTo(20)
        }
        archivesLab.snp_makeConstraints { (make) in
            make.top.equalTo(TitleLab.snp_bottom).offset(3)
            make.left.equalTo(userImg.snp_right).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(15)
        }
        playLab.snp_makeConstraints { (make) in
            make.top.equalTo(TitleLab.snp_bottom).offset(3)
            make.left.equalTo(archivesLab.snp_right).offset(10)
            make.height.equalTo(15)
        }
        descLab.snp_makeConstraints { (make) in
            make.top.equalTo(archivesLab.snp_bottom).offset(3)
            make.left.equalTo(userImg.snp_right).offset(10)
            make.right.equalTo(self).offset(-8)
            make.height.equalTo(15)
        }
    }
    
    //MARK: -- setter and getter
    var _userImg: UIImageView!
    var userImg: UIImageView {
        if _userImg == nil {
            _userImg = UIImageView()
            _userImg.layer.masksToBounds = true
            _userImg.layer.cornerRadius = 8.0
        }
        return _userImg
    }
    
    var _TitleLab: UILabel!
    var TitleLab: UILabel {
        if _TitleLab == nil {
            _TitleLab = UILabel()
            _TitleLab.font = UIFont.systemFontOfSize(14)
        }
        return _TitleLab
    }
    
    var _archivesLab: UILabel!
    var archivesLab: UILabel {
        if _archivesLab == nil {
            _archivesLab = UILabel()
            _archivesLab.textColor = UIColor.grayColor()
            _archivesLab.font = UIFont.systemFontOfSize(12)
        }
        return _archivesLab
    }
    
    var _playLab: UILabel!
    var playLab: UILabel {
        if _playLab == nil {
            _playLab = UILabel()
            _playLab.textColor = UIColor.grayColor()
            _playLab.font = UIFont.systemFontOfSize(12)
        }
        return _playLab
    }
    
    var _descLab: UILabel!
    var descLab: UILabel {
        if _descLab == nil {
            _descLab = UILabel()
            _descLab.textColor = UIColor.grayColor()
            _descLab.font = UIFont.systemFontOfSize(12)
        }
        return _descLab
    }
    
    //数据源
    var _subModel: SubModel!
    var subModel: SubModel {
        get {
            return _subModel
        }
        set {
            _subModel = newValue
            _userImg.sd_setImageWithURL(NSURL(string: newValue.cover!))
            _TitleLab.text = newValue.title
            _archivesLab.text = String.init(format: "视频：%d", newValue.archives!)
            _playLab.text = String.init(format: "播放：%d", newValue.play!)
            if newValue.desc != nil {
                _descLab.text = newValue.desc
            }
        }
    }
}
