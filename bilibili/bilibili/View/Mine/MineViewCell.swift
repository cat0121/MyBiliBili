//
//  MineViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/20.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class MineViewCell: UICollectionViewCell {
    
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
        self.addSubview(infoImg)
        self.addSubview(infoTitle)
    }
    func layoutPageSubviews() {
        
        infoImg.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.centerX.equalTo(self)
            make.height.equalTo(31)
        }
        infoTitle.snp_makeConstraints { (make) in
            make.top.equalTo(infoImg.snp_bottom).offset(2)
            make.width.equalTo(self.bounds.size.width)
            make.height.equalTo(20)
        }
    }
    
    //MARK: -- setter and getter
    var _infoImg: UIImageView!
    var infoImg: UIImageView {
        if _infoImg == nil {
            _infoImg = UIImageView()
        }
        return _infoImg
    }
    
    var _infoTitle: UILabel!
    var infoTitle: UILabel {
        if _infoTitle == nil {
            _infoTitle = UILabel()
            _infoTitle.textAlignment = .Center
            _infoTitle.font = UIFont.systemFontOfSize(13)
        }
        return _infoTitle
    }
}
