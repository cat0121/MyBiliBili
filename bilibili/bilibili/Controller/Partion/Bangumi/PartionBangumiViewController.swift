//
//  PartionBangumiViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/18.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class PartionBangumiViewController: UIViewController {
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initConfig()
    }
    
    //MARK: -- private method
    func initConfig() {
        let recommend = BangumiRecommendViewController()
        recommend.title = "推荐"
        let serial = SerialCartoonViewController()
        serial.title = "连载动画"
        let endCartoon = EndCartoonViewController()
        endCartoon.title = "完结动画"
        let china = ChinaCartoonViewController()
        china.title = "国产动画"
        let infomation = InfomationViewController()
        infomation.title = "资讯"
        let offical = OfficalViewController()
        offical.title = "官方延伸"
        
        let scnav = SCNavTabBarController()
        scnav.subViewControllers = [recommend,serial,endCartoon,china,infomation,offical]
        scnav.navTabBarColor = UIColor(red: 0.89, green: 0.49, blue: 0.61, alpha: 1)
        self.title = "番剧"
        scnav.addParentController(self)
        self.navigationItem.leftBarButtonItem = leftBackBtn
        self.tabBarController?.tabBar.hidden = true
    }
    
    func backClick(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    //MARK: -- setter and getter
    // 导航栏左侧按钮
    var _leftBackBtn:UIBarButtonItem!
    var leftBackBtn:UIBarButtonItem{
        if _leftBackBtn == nil{
            _leftBackBtn = UIBarButtonItem(image: UIImage(named: "fullplayer_icon_back"), style: .Plain, target: self, action: #selector(PartionBangumiViewController.backClick(_:)))
            _leftBackBtn.tintColor = UIColor.whiteColor()
            
        }
        return _leftBackBtn
    }

}