//
//  SearchUPViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/16.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class SearchUPViewCell:  UITableViewCell {
    
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
        self.addSubview(fansLab)
        self.addSubview(archivesLab)
        self.addSubview(signLab)
    }
    func layoutPageSubviews() {
        userImg.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.width.equalTo(SCREEN_HEIGHT*0.1)
            make.height.equalTo(SCREEN_HEIGHT*0.1)
        }
        TitleLab.snp_makeConstraints { (make) in
            make.left.equalTo(userImg.snp_right).offset(10)
            make.top.equalTo(self).offset(10)
            make.height.equalTo(20)
        }
        fansLab.snp_makeConstraints { (make) in
            make.left.equalTo(userImg.snp_right).offset(10)
            make.top.equalTo(TitleLab.snp_bottom).offset(5)
            make.height.equalTo(15)
            make.width.equalTo(SCREEN_WIDTH*0.4)
        }
        archivesLab.snp_makeConstraints { (make) in
            make.left.equalTo(fansLab.snp_right).offset(0)
            make.top.equalTo(TitleLab.snp_bottom).offset(5)
            make.height.equalTo(15)
        }
        signLab.snp_makeConstraints { (make) in
            make.top.equalTo(fansLab.snp_bottom).offset(10)
            make.left.equalTo(userImg.snp_right).offset(10)
            make.height.equalTo(15)
        }
    }
    
    //MARK: -- setter and getter
    var _userImg: UIImageView!
    var userImg: UIImageView {
        if _userImg == nil {
            _userImg = UIImageView()
            _userImg.layer.masksToBounds = true
            _userImg.layer.cornerRadius = 33.0
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
    
    var _fansLab: UILabel!
    var fansLab: UILabel {
        if _fansLab == nil {
            _fansLab = UILabel()
            _fansLab.textColor = UIColor.grayColor()
            _fansLab.font = UIFont.systemFontOfSize(12)
        }
        return _fansLab
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
    
    var _signLab: UILabel!
    var signLab: UILabel {
        if _signLab == nil {
            _signLab = UILabel()
            _signLab.textColor = UIColor.grayColor()
            _signLab.font = UIFont.systemFontOfSize(12)
        }
        return _signLab
    }
    //数据源
    var _upModel: UPModel!
    var upModel: UPModel {
        get {
            return _upModel
        }
        set {
            _upModel = newValue
            _userImg.sd_setImageWithURL(NSURL(string: newValue.cover!) ,placeholderImage: UIImage(named: "default_img"))
            _TitleLab.text = newValue.title
            _fansLab.text = String.init(format: "粉丝：%d", newValue.fans!)
            _archivesLab.text = String.init(format: "视频：%d", newValue.archives!)
            if newValue.sign != nil {
                _signLab.text = newValue.sign
            }
        }
    }
}
