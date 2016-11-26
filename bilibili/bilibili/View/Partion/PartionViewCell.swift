//
//  PartionViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/17.
//  Copyright © 2016年 yan. All rights reserved.
//

import Foundation
import UIKit

class PartionViewCell: UICollectionViewCell {
    
    //MARK: -- life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initBaseLayout()
        layoutPageSubViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.addSubview(backImg)
        backImg.addSubview(partionImg)
        self.addSubview(partionTitle)
    }
    func layoutPageSubViews() {
        backImg.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(2)
            make.left.equalTo(self).offset(16)
            make.bottom.equalTo(self).offset(-17)
            make.centerX.equalTo(self)
            
        }
        partionImg.snp_makeConstraints { (make) in
            make.centerX.equalTo(backImg)
            make.centerY.equalTo(backImg)
        }
        partionTitle.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(backImg.snp_bottom).offset(0)
            make.height.equalTo(18)
        }
    }
    
    //MARK: -- setter and getter
    var _backImg: UIImageView!
    var backImg: UIImageView {
        if _backImg == nil {
            _backImg = UIImageView()
            _backImg.image = UIImage(named: "home_subregion_border")
        }
        return _backImg
    }
    
    var _partionImg: UIImageView!
    var partionImg: UIImageView {
        if _partionImg == nil {
            _partionImg = UIImageView()
        }
        return _partionImg
    }
    
    var _partionTitle: UILabel!
    var partionTitle: UILabel {
        if _partionTitle == nil {
            _partionTitle = UILabel()
            _partionTitle.textAlignment = .Center
            _partionTitle.textColor = UIColor.blackColor()
            _partionTitle.font = UIFont.systemFontOfSize(12)
        }
        return _partionTitle
    }
    
    //数据源
    var _partionModel: PartionModel!
    var partionModel: PartionModel {
        get {
            return _partionModel
        }
        set {
            _partionModel = newValue
            partionTitle.text = newValue.name
        }
    }
}