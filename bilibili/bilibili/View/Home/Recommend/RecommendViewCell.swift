//
//  RecommendViewCell.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/9.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class RecommendViewCell: UICollectionViewCell {
    
    //MARK: -- private method
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //初始化界面
        initBaseLayout()
        layoutPageSubViews()
//        let gradientyLayer = CAGradientLayer()
//        gradientyLayer.frame = self.bounds
//        gradientyLayer.colors = [UIColor.whiteColor(),UIColor.lightGrayColor(),UIColor.grayColor(),UIColor.blackColor()]
//        self.layer.addSublayer(gradientyLayer)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.contentView.addSubview(recImageView)
        self.contentView.addSubview(recTitle)
        self.recImageView.addSubview(detailView)
        self.detailView.addSubview(videoImageView)
        self.detailView.addSubview(videoLabel)
        self.detailView.addSubview(commentImageView)
        self.detailView.addSubview(commentLabel)
    }
    func layoutPageSubViews() {
        recImageView.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(3)
            make.left.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).offset(0)
            make.height.equalTo(contentView.frame.size.height-40)
        }
        recTitle.snp_makeConstraints { (make) in
            make.top.equalTo(recImageView.snp_bottom).offset(3)
            make.width.equalTo(contentView.frame.size.width)
        }
        detailView.snp_makeConstraints { (make) in
            make.bottom.equalTo(recImageView.snp_bottom).offset(0)
            make.left.equalTo(self.contentView).offset(0)
            make.right.equalTo(self.contentView).offset(0)
            make.height.equalTo(25)
        }
        videoImageView.snp_makeConstraints { (make) in
            make.left.equalTo(detailView.snp_left).offset(10)
            make.bottom.equalTo(detailView.snp_bottom).offset(-3)
            make.height.equalTo(15)
            make.width.equalTo(20)
        }
        videoLabel.snp_makeConstraints { (make) in
            make.left.equalTo(videoImageView.snp_right).offset(5)
            make.bottom.equalTo(detailView.snp_bottom).offset(-3)
            make.height.equalTo(18)
            make.width.equalTo(50)
        }
        commentImageView.snp_makeConstraints { (make) in
            make.left.equalTo(detailView.snp_left).offset(contentView.frame.size.width/2)
            make.bottom.equalTo(detailView.snp_bottom).offset(-3)
            make.height.equalTo(15)
            make.width.equalTo(20)
        }
        commentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(commentImageView.snp_right).offset(5)
            make.bottom.equalTo(detailView.snp_bottom).offset(-3)
            make.height.equalTo(18)
            make.width.equalTo(50)
        }

    }
    
    //MARK: -- setter and getter
    var _recImageView: UIImageView!
    var recImageView: UIImageView {
        if _recImageView == nil {
            _recImageView = UIImageView()
            _recImageView.layer.cornerRadius = 10.0
            _recImageView.layer.masksToBounds = true
        }
        return _recImageView
    }
    
    var _recTitle: UILabel!
    var recTitle: UILabel {
        if _recTitle == nil {
            _recTitle = UILabel()
            _recTitle.textColor = UIColor.blackColor()
            _recTitle.font = UIFont.systemFontOfSize(13)
            _recTitle.numberOfLines = 2
        }
        return _recTitle
    }
    
    var _detailView: UIView!
    var detailView: UIView {
        if _detailView == nil {
            _detailView = UIView()
            _detailView.backgroundColor = UIColor.grayColor()
            _detailView.alpha = 0.8
        }
        return _detailView
    }
    
    var _videoImageView: UIImageView!
    var videoImageView: UIImageView {
        if _videoImageView == nil {
            _videoImageView = UIImageView()
            _videoImageView.image = UIImage(named: "recommend_videoInfo_views")?.imageWithRenderingMode(.AlwaysOriginal)
        }
        return _videoImageView
    }
    
    var _videoLabel: UILabel!
    var videoLabel: UILabel {
        if _videoLabel == nil {
            _videoLabel = UILabel()
            _videoLabel.numberOfLines = 1
            _videoLabel.textColor = UIColor.whiteColor()
            _videoLabel.font = UIFont.systemFontOfSize(10)
        }
        return _videoLabel
    }
    
    var _commentImageView: UIImageView!
    var commentImageView: UIImageView {
        if _commentImageView == nil {
            _commentImageView = UIImageView()
            _commentImageView.image = UIImage(named: "recommed_danmuCount")?.imageWithRenderingMode(.AlwaysOriginal)
        }
        return _commentImageView
    }
    
    var _commentLabel: UILabel!
    var commentLabel: UILabel {
        if _commentLabel == nil {
            _commentLabel = UILabel()
            _commentLabel.numberOfLines = 1
            _commentLabel.textColor = UIColor.whiteColor()
            _commentLabel.font = UIFont.systemFontOfSize(10)
        }
        return _commentLabel
    }
    //数据源
    var _bodyModel: RecBodyModel!
    var bodyModel: RecBodyModel {
        get  {
            return _bodyModel
        }
        set {
            _bodyModel = newValue
            recTitle.text = newValue.title
            videoLabel.text = String(newValue.playcount)
            commentLabel.text = String(newValue.danmaku)
            recImageView.sd_setImageWithURL(NSURL(string:  newValue.bodyImage!), placeholderImage: UIImage(named: "default_img"))
        }
    }
}