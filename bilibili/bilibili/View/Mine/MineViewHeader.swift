//
//  MineViewHeader.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/20.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class MineViewHeader: UICollectionReusableView {
    
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
        self.addSubview(sectionLabel)
    }
    func layoutPageSubviews() {
        sectionLabel.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 10, 0, 0))
        }
    }
    
    //MARK: -- setter and getter
    var _sectionLabel: UILabel!
    var sectionLabel: UILabel {
        if _sectionLabel == nil {
            _sectionLabel = UILabel()
            _sectionLabel.font = UIFont.systemFontOfSize(15)
        }
        return _sectionLabel
    }
}
