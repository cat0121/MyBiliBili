//
//  PartionMusicViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class PartionMusicViewController: UIViewController {
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initConfig()
    }
    
    //MARK: -- private method
    func initConfig() {
        let recommend = MusicRecommendViewController()
        recommend.title = "推荐"
        let reprise = MusicRepriseViewController()
        reprise.title = "翻唱"
        let VOCALOID = VOCALOIDViewController()
        VOCALOID.title = "VOCALOID*UTAU"
        let play = PlayMusicViewController()
        play.title = "演奏"
        let OP = OPViewController()
        OP.title = "OP/ED/OST"
        let original = OriginalViewController()
        original.title = "原创音乐"
        let three = ThreeViewController()
        three.title = "三次元音乐"
        let musicSet = MusicSetViewController()
        musicSet.title = "音乐选集"
        
        let scnav = SCNavTabBarController()
        scnav.subViewControllers = [recommend,reprise,VOCALOID,play,OP,original,three,musicSet]
        scnav.navTabBarColor = UIColor(red: 0.89, green: 0.49, blue: 0.61, alpha: 1)
        self.title = "音乐"
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