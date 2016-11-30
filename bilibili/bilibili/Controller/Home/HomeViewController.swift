//
//  HomeViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加所有的控制器
        setUpAllViewController()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    //MARK: -- private method
    func setUpAllViewController() {
        //直播
        let live = LiveViewController()
        live.title = "       直播        "
        //推荐
        let recommend = RecommendViewController()
        recommend.title = "       推荐       "
        //番剧
        let bangumi = BangumiViewController()
        bangumi.title = "       番剧       "
        
        let sdnav = SCNavTabBarController()
        sdnav.subViewControllers = [live,recommend,bangumi]
        sdnav.navTabBarColor = UIColor(red: 0.89, green: 0.49, blue: 0.61, alpha: 1)
        self.view.backgroundColor = UIColor.whiteColor()
        sdnav.addParentController(self)
    }
    
}
