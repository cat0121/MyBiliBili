//
//  SerialCartoonHeaderView.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/21.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import UIKit

class SerialCartoonHeaderView: UITableViewHeaderFooterView {
    
    //MARK: -- life cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.initBaseLayout()
        self.layoutPageSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.addSubview(serImg)
        self.addSubview(serTitle)
    }
    func layoutPageSubviews() {
        serImg.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(self).offset(5)
            make.width.equalTo(20)
            make.height.equalTo(15)
        }
        serTitle.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(serImg.snp_right).offset(2)
            make.height.equalTo(20)
        }
    }
    
    //MARK: -- setter and getter
    var _serImg: UIImageView!
    var serImg: UIImageView {
        if _serImg == nil {
            _serImg = UIImageView()
        }
        return _serImg
    }
    
    var _serTitle: UILabel!
    var serTitle: UILabel {
        if _serTitle == nil {
            _serTitle = UILabel()
            _serTitle.font = UIFont.systemFontOfSize(14)
        }
        return _serTitle
    }
}