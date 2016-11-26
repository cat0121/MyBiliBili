//
//  RecommendViewFooter.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/14.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit
import SnapKit

class RecommendViewFooter: UICollectionReusableView {
    
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
       self.addSubview(recImage)
    }
    func layoutPageSubviews() {
        recImage.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    //MARK: -- setter and getter
    var _recImage: UIImageView!
    var recImage: UIImageView {
        if _recImage == nil {
            _recImage = UIImageView()
        }
        return _recImage
    }
}