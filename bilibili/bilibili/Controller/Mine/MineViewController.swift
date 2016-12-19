//
//  MineViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {
    //头像：mine_bg_avatar
    //等级：misc_level_colorfulLv%d
    //个人中心
    let mineCenter = ["mine_download","mine_history","mine_favourite","mine_follow","mine_pocketcenter","mine_vip_icon,mine_gamecenter","mine_theme","mine_bigvip_icon"]
    //我的消息
    let mineMessage = ["mine_answerMessage","message_at","mine_gotPrise","mine_message","mine_systemNotification"]
    //MARK: --   life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseLayout()
        layoutPageSubviews()
    }
    
    //MARK: -- private method
    func initBaseLayout() {
        self.view.addSubview(headerView)
        self.headerView.addSubview(avatarBackImg)
        self.avatarBackImg.addSubview(avatarImg)
    }
    func layoutPageSubviews() {
        headerView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT*0.225)
        }
        _avatarBackImg.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(60)
            make.left.equalTo(self.view).offset(10)
            make.width.equalTo(SCREEN_WIDTH*0.245)
            make.height.equalTo(SCREEN_WIDTH*0.245)
        }
        _avatarImg.snp_makeConstraints { (make) in
            make.top.equalTo(avatarBackImg.snp_top).offset(10)
            make.bottom.equalTo(avatarBackImg.snp_bottom).offset(-10)
            make.left.equalTo(avatarBackImg.snp_left).offset(10)
            make.right.equalTo(avatarBackImg.snp_right).offset(-10)
        }
    }
    
    //MARK: -- setter and getter
    var _headerView: UIView!
    var headerView: UIView {
        if _headerView == nil {
            _headerView.backgroundColor = YYMain_Color
        }
        return _headerView
    }
    var _avatarBackImg: UIImageView!
    var avatarBackImg: UIImageView {
        if _avatarBackImg == nil {
            _avatarBackImg = UIImageView()
            _avatarBackImg.image = UIImage(named: "mine_bg_avatar")
        }
        return _avatarBackImg
    }
    var _avatarImg: UIImageView!
    var avatarImg: UIImageView {
        if _avatarImg == nil {
            _avatarImg = UIImageView()
            _avatarImg.backgroundColor = UIColor.redColor()
        }
        return _avatarImg
    }
}
