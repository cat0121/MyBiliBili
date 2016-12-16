//
//  SearchSynthesisViewHeader.swift
//  bilibili
//
//  Created by fengshuyan on 2016/12/16.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class SearchSynthesisViewHeader: UIView {
    
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
        self.addSubview(synthesisImg)
        self.addSubview(bangumiImg)
        self.addSubview(bangumiTitle)
        self.addSubview(headerTitle)
        self.addSubview(seasonInfo)
        self.addSubview(cat_descLab)
    }
    func layoutPageSubviews() {
        synthesisImg.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.height.equalTo(SCREEN_HEIGHT*0.185)
            make.width.equalTo(SCREEN_WIDTH*0.24)
        }
        bangumiImg.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(synthesisImg.snp_right).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        bangumiTitle.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(bangumiImg.snp_right).offset(3)
            make.height.equalTo(20)
        }
        headerTitle.snp_makeConstraints { (make) in
            make.top.equalTo(bangumiImg.snp_bottom).offset(5)
            make.left.equalTo(synthesisImg.snp_right).offset(10)
            make.height.equalTo(20)
        }
        seasonInfo.snp_makeConstraints { (make) in
            make.top.equalTo(headerTitle.snp_bottom).offset(3)
            make.left.equalTo(synthesisImg.snp_right).offset(10)
            make.height.equalTo(15)
        }
        cat_descLab.snp_makeConstraints { (make) in
            make.top.equalTo(seasonInfo.snp_bottom).offset(3)
            make.left.equalTo(synthesisImg.snp_right).offset(10)
            make.height.equalTo(15)
        }
        
    }
    
    //setter and getter
    var _synthesisImg: UIImageView!
    var synthesisImg: UIImageView {
        if _synthesisImg == nil {
            _synthesisImg = UIImageView()
            _synthesisImg.layer.cornerRadius = 8.0
            _synthesisImg.layer.masksToBounds = true
        }
        return _synthesisImg
    }
    
    var _bangumiImg: UIImageView!
    var bangumiImg: UIImageView {
        if _bangumiImg == nil {
            _bangumiImg = UIImageView()
            _bangumiImg.image = UIImage(named: "home_subregion_bangumi")
        }
        return _bangumiImg
    }
    
    var _bangumiTitle: UILabel!
    var bangumiTitle: UILabel {
        if _bangumiTitle == nil {
            _bangumiTitle = UILabel()
            _bangumiTitle.text = "番剧"
            _bangumiTitle.textColor = UIColor.grayColor()
            _bangumiTitle.font = UIFont.systemFontOfSize(11)
        }
        return _bangumiTitle
    }
    
    var _headerTitle: UILabel!
    var headerTitle: UILabel {
        if _headerTitle == nil {
            _headerTitle = UILabel()
            _headerTitle.textColor = UIColor.blackColor()
            _headerTitle.font = UIFont.systemFontOfSize(15)
        }
        return _headerTitle
    }
    
    var _seasonInfo: UILabel!
    var seasonInfo: UILabel {
        if _seasonInfo == nil {
            _seasonInfo = UILabel()
            _seasonInfo.textColor = UIColor.grayColor()
            _seasonInfo.font = UIFont.systemFontOfSize(11)
        }
        return _seasonInfo
    }
    
    var _cat_descLab: UILabel!
    var cat_descLab: UILabel {
        if _cat_descLab == nil {
            _cat_descLab = UILabel()
            _cat_descLab.textColor = UIColor.grayColor()
            _cat_descLab.font = UIFont.systemFontOfSize(11)
        }
        return _cat_descLab
    }
    
    //数据源
    var _seasonModel: SeasonModel!
    var seasonModel: SeasonModel {
        get {
            return _seasonModel
        }
        set {
            _seasonModel = newValue
            _synthesisImg.sd_setImageWithURL(NSURL(string: newValue.cover!), placeholderImage: UIImage(named: "default_img"))
            _headerTitle.text = newValue.title
            _seasonInfo.text = String.init(format: "%@ 更新至第%@话", newValue.newest_season!, newValue.index!)
            _cat_descLab.text = newValue.cat_desc
        }
    }
}