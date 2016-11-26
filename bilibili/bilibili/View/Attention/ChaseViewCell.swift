//
//  ChaseViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/24.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class ChaseViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.addSubview(chaseImg)
        self.addSubview(chaseTitle)
        self.addSubview(chaseWatch)
        self.addSubview(chaseNew)
    }
    func layoutPageSubviews() {
        chaseImg.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(7)
            make.centerY.equalTo(self)
            make.width.equalTo(SCREEN_WIDTH*0.186)
            make.height.equalTo(SCREEN_HEIGHT*0.14)
        }
        chaseTitle.snp_makeConstraints { (make) in
            make.left.equalTo(chaseImg.snp_right).offset(10)
            make.top.equalTo(self).offset(10)
            make.height.equalTo(20)
        }
        chaseWatch.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(7)
            make.top.equalTo(chaseTitle.snp_bottom).offset(5)
            make.height.equalTo(20)
        }
        chaseNew.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(7)
            make.top.equalTo(chaseWatch.snp_bottom).offset(5)
            make.height.equalTo(20)
        }
    }
    
    //MARK: -- setter and getter
    var _chaseImg: UIImageView!
    var chaseImg: UIImageView {
        if _chaseImg == nil {
            _chaseImg = UIImageView()
            _chaseImg.layer.cornerRadius = 10.0
            _chaseImg.layer.masksToBounds = true
        }
        return _chaseImg
    }
    var _chaseTitle: UILabel!
    var chaseTitle: UILabel {
        if _chaseTitle == nil {
            _chaseTitle = UILabel()
            _chaseTitle.font = UIFont.systemFontOfSize(14)
        }
        return _chaseTitle
    }
    var _chaseWatch: UILabel!
    var chaseWatch: UILabel {
        if _chaseWatch == nil {
            _chaseWatch = UILabel()
            _chaseWatch.textColor = UIColor.grayColor()
            _chaseWatch.font = UIFont.systemFontOfSize(10)
        }
        return _chaseWatch
    }
    var _chaseNew: UILabel!
    var chaseNew: UILabel {
        if _chaseNew == nil {
            _chaseNew = UILabel()
            _chaseNew.textColor = UIColor.grayColor()
            _chaseNew.font = UIFont.systemFontOfSize(10)
        }
        return _chaseWatch
    }
}