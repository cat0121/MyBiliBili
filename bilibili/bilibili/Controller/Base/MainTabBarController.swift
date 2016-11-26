//
//  MainTabBarController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //Mark: -- life cycle
    override func viewDidLoad() {
        initConfig()
    }
    
    //MARK: -- private method
    func initConfig() {
        self.tabBar.tintColor = YYMain_Color
        //首页
        let home = HomeViewController()
        addChildViewController(home, imageName: "home_home_tab", title: "首页")
        //分区
        let partion = PartionViewController()
        addChildViewController(partion, imageName: "home_class_tab", title: "分区")
        //关注
        let attention = AttentionViewController()
        addChildViewController(attention, imageName: "home_attention_tab", title: "关注")
        //发现
        let search = SearchViewController()
        addChildViewController(search, imageName: "home_discovery_tab", title: "发现")
        //我的
        let mine = MineViewController()
        addChildViewController(mine, imageName: "home_mine_tab", title: "我的")
    }
    
    func addChildViewController(controller: UIViewController, imageName: String, title: String) {
        
        controller.tabBarItem.image = UIImage(named: imageName)
        controller.title = title
        
        let nav = UINavigationController(rootViewController: controller)
        self.addChildViewController(nav)
    }
}
