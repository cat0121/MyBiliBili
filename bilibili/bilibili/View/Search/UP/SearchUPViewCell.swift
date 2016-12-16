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
        
    }
    func layoutPageSubviews() {
        userImg.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.width.equalTo(SCREEN_WIDTH*0.1)
            make.height.equalTo(SCREEN_WIDTH*0.1)
        }
    }

    //MARK: -- setter and getter
    var _userImg: UIImageView!
    var userImg: UIImageView {
        if _userImg == nil {
            _userImg = UIImageView()
            _userImg.layer.masksToBounds = true
            _userImg.layer.cornerRadius = 19.0
        }
        return _userImg
    }
    
    var _TitleLab: UILabel!
    var TitleLab: UILabel {
        if _TitleLab == nil {
            _TitleLab = UILabel()
            _TitleLab.font = UIFont.systemFontOfSize(15)
        }
        return _TitleLab
    }
    
    var _fansLab: UILabel!
    var fansLab: UILabel {
        if _fansLab == nil {
            _fansLab = UILabel()
            _fansLab.textColor = UIColor.grayColor()
            _fansLab.font = UIFont.systemFontOfSize(11)
        }
        return _fansLab
    }
    
    var _archivesLab: UILabel!
    var archivesLab: UILabel {
        if _archivesLab == nil {
            _archivesLab = UILabel()
            _archivesLab.textColor = UIColor.grayColor()
            _archivesLab.font = UIFont.systemFontOfSize(11)
        }
        return _archivesLab
    }
    
    var _signLab: UILabel!
    var signLab: UILabel {
        if _signLab == nil {
            _signLab = UILabel()
            _signLab.textColor = UIColor.grayColor()
            _signLab.font = UIFont.systemFontOfSize(11)
        }
        return _signLab
    }
}
