//
//  PersonViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/30.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class PersonViewCell: UITableViewCell {

    //MARK: -- life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initBaseLayout()
        layoutPageSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: -- private method
    func initBaseLayout() {
        self.addSubview(tagLab)
        self.addSubview(userLab)
    }
    func layoutPageSubview() {
        tagLab.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        userLab.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-30)
            make.centerY.equalTo(self)
            make.height.equalTo(20)
        }
    }
    
    //MAKE: -- setter and getter
    var _tagLab: UILabel!
    var tagLab: UILabel {
        if _tagLab == nil {
            _tagLab = UILabel()
            _tagLab.font = UIFont.systemFontOfSize(15)
        }
        return _tagLab
    }
    var _userLab: UILabel!
    var userLab: UILabel {
        if _userLab == nil {
            _userLab = UILabel()
            _userLab.textColor = UIColor.grayColor()
            _userLab.font = UIFont.systemFontOfSize(14)
            _userLab.textAlignment = .Right
        }
        return _userLab
    }
}

class PersonImgCell: UITableViewCell {
    //MARK: -- life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initBaseLayout()
        layoutPageSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: -- private method
    func initBaseLayout() {
        self.addSubview(tagLab)
        self.addSubview(userIcon)
    }
    func layoutPageSubview() {
        tagLab.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        userIcon.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-30)
            make.centerY.equalTo(self)
            make.height.equalTo(65)
            make.width.equalTo(65)
        }
    }
    
    //MAKE: -- setter and getter
    var _tagLab: UILabel!
    var tagLab: UILabel {
        if _tagLab == nil {
            _tagLab = UILabel()
            _tagLab.font = UIFont.systemFontOfSize(15)
        }
        return _tagLab
    }
    var _userIcon: UIImageView!
    var userIcon: UIImageView {
        if _userIcon == nil {
            _userIcon = UIImageView()
        }
        return _userIcon
    }

}

class LoginOutCell: UITableViewCell {
    //MARK: -- life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initBaseLayout()
        layoutPageSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.addSubview(loginOut)
    }
    func layoutPageSubview() {
        loginOut.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    //MAKE: -- setter and getter
    var _loginOut: UIButton!
    var loginOut: UIButton {
        if _loginOut == nil {
            _loginOut = UIButton(type: .Custom)
            _loginOut.setTitle("退出登录", forState: .Normal)
            _loginOut.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        return _loginOut
    }

}