//
//  AttentionViewController.swift
//  bilibili
//
//  Created by fengshuyan on 2016/11/7.
//  Copyright © 2016年 yan. All rights reserved.
//

import UIKit

class AttentionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initConfig()
    }
    
    //MARK: -- private method
    func initConfig(){
        let chase = ChaseViewController()
        chase.title = "      追番      "
        let dynamic = DynamicViewController()
        dynamic.title = "        动态        "
        let mark = MarkViewController()
        mark.title = "       标签      "
        
        let sdnav = SCNavTabBarController()
        sdnav.subViewControllers = [chase,dynamic,mark]
        sdnav.navTabBarColor = UIColor(red: 0.89, green: 0.49, blue: 0.61, alpha: 1)
        self.view.backgroundColor = UIColor.whiteColor()
        sdnav.addParentController(self)
    }
}
