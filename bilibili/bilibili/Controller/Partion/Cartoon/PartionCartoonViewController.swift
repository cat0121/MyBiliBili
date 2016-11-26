//
//  PartionCartoonViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/23.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class PartionCartoonViewController: UIViewController {
    
    //MARK: --life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initConfig()
    }
    
    //MARK: -- private method
    func initConfig() {
        let recommend = CartoonRecommendViewController()
        recommend.title = "推荐"
        let MAD = MADViewController()
        MAD.title = "MAD*AMV"
        let MMD = MMDViewController()
        MMD.title = "MMD*3D"
        let shortFilm = ShortFilmViewController()
        shortFilm.title = "短片*手书*配音"
        let synthesis = SynthesisViewController()
        synthesis.title = "综合"
        
        let scnav = SCNavTabBarController()
        scnav.subViewControllers = [recommend,MAD,MMD,shortFilm,synthesis]
        scnav.navTabBarColor = UIColor(red: 0.89, green: 0.49, blue: 0.61, alpha: 1)
        self.title = "动画"
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
