//
//  PersonalInfoView.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/22.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class PersonalInfoView: UIView {
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
        self.addSubview(avatarImg)
        self.addSubview(avatarName)
        self.addSubview(sexImg)
        self.addSubview(levelProgress)
        self.addSubview(levelImg)
        self.addSubview(attention)
        self.addSubview(fansLab)
        self.addSubview(signLab)
    }
    func layoutPageSubviews() {
        avatarImg.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(-SCREEN_WIDTH*0.11)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(SCREEN_WIDTH*0.22)
            make.height.equalTo(SCREEN_WIDTH*0.22)
        }
        avatarName.snp_makeConstraints { (make) in
            make.top.equalTo(avatarImg.snp_bottom).offset(10)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        sexImg.snp_makeConstraints { (make) in
            make.left.equalTo(avatarName.snp_right).offset(10)
            make.top.equalTo(avatarImg.snp_bottom).offset(12)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        levelProgress.snp_makeConstraints { (make) in
            make.top.equalTo(avatarImg.snp_bottom).offset(13)
            make.left.equalTo(sexImg.snp_right).offset(25)
            make.width.equalTo(80)
            make.height.equalTo(12)
        }
        levelImg.snp_makeConstraints { (make) in
            make.left.equalTo(sexImg.snp_right).offset(3)
            make.top.equalTo(avatarImg.snp_bottom).offset(11)
            make.width.equalTo(25)
            make.height.equalTo(15)
        }
        attention.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(avatarName.snp_bottom).offset(8)
            make.height.equalTo(20)
        }
        fansLab.snp_makeConstraints { (make) in
            make.left.equalTo(attention.snp_right).offset(10)
            make.top.equalTo(avatarName.snp_bottom).offset(8)
            make.height.equalTo(20)
        }
        signLab.snp_makeConstraints { (make) in
            make.top.equalTo(attention.snp_bottom).offset(8)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(20)
        }
    }
    
    //MARK: -- setter and getter
    var _avatarImg: UIImageView!
    var avatarImg: UIImageView {
        if _avatarImg == nil {
            _avatarImg = UIImageView()
            _avatarImg.backgroundColor = UIColor.redColor()
            _avatarImg.layer.masksToBounds = true
            _avatarImg.layer.cornerRadius = 42.5
        }
        return _avatarImg
    }
    var _avatarName: UILabel!
    var avatarName: UILabel {
        if _avatarName == nil {
            _avatarName = UILabel()
            _avatarName.font = UIFont.systemFontOfSize(18)
            _avatarName.text = "萌小猫121"
        }
        return _avatarName
    }
    var _sexImg: UIImageView!
    var sexImg: UIImageView {
        if _sexImg == nil {
            _sexImg = UIImageView()
            _sexImg.image = UIImage(named: "gril_icon_normal")
        }
        return _sexImg
    }
    var _levelImg: UIImageView!
    var levelImg: UIImageView {
        if _levelImg == nil {
            _levelImg = UIImageView()
        }
        return _levelImg
    }
    var _levelProgress: UIProgressView! //misc_level_whiteLv
    var levelProgress: UIProgressView {
        if _levelProgress == nil {
            _levelProgress = UIProgressView()
            _levelProgress.progressTintColor = UIColor(red: 171/255.0, green: 219/255.0, blue: 178/255.0, alpha: 1)
            _levelProgress.trackTintColor = UIColor.blackColor()
            _levelProgress.layer.masksToBounds = true
            _levelProgress.layer.cornerRadius = 6.0
        }
        return _levelProgress
    }
    var _attention: UILabel!
    var attention: UILabel {
        if _attention == nil {
            _attention = UILabel()
            _attention.textColor = UIColor.grayColor()
            _attention.font = UIFont.systemFontOfSize(14)
            _attention.text = "0  粉丝"
        }
        return _attention
    }
    var _fansLab: UILabel!
    var fansLab: UILabel {
        if _fansLab == nil {
            _fansLab = UILabel()
            _fansLab.textColor = UIColor.grayColor()
            _fansLab.font = UIFont.systemFontOfSize(14)
            _fansLab.text = "0  关注"
        }
        return _fansLab
    }
    var _signLab: UILabel!
    var signLab: UILabel {
        if _signLab == nil {
            _signLab = UILabel()
            _signLab.font = UIFont.systemFontOfSize(13)
            _signLab.textColor = UIColor.grayColor()
        }
        return _signLab
    }
    
    //数据源
    var _personData: MineViewModel!
    var personData: MineViewModel {
        get {
            return _personData
        }
        set {
            _personData = newValue
            _avatarImg.sd_setImageWithURL(NSURL(string: newValue.face!) ,placeholderImage: UIImage(named: "default_img"))
            _avatarName.text = newValue.uname
            _levelProgress.progress = Float(newValue.current_exp!)/Float(newValue.next_exp!)
            let str = String.init(format: "misc_level_whiteLv%d", newValue.current_level!)
            _levelImg.image = UIImage(named: str)
            _signLab.text = newValue.sign
        }
    }
}
